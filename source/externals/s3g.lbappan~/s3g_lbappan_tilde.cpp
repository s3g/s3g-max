#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_layout_panner.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <string>

namespace {

constexpr long kDefaultInputs = 8;
constexpr long kDefaultOutputs = 16;
constexpr long kMaxInputs = s3g::kLayoutPannerSources;
constexpr long kMaxOutputs = s3g::kLayoutPannerMaxSpeakers;

struct LbapPanImpl {
    s3g::LayoutPanner panner;
    s3g::LayoutPannerParams params;
    std::array<float, kMaxInputs> frameIn {};
    std::array<float, kMaxOutputs> frameOut {};
    double sampleRate = 48000.0;
    long inputCount = kDefaultInputs;
    long outputCount = kDefaultOutputs;
    bool prepared = false;
};

struct t_s3g_lbappan {
    t_pxobject object;
    LbapPanImpl* impl = nullptr;
    void* infoOutlet = nullptr;
    double layout = 3.0;
    double method = 0.0;
    double focus = 1.0;
    double rolloff = 6.0;
    double smooth = 35.0;
    double globalaz = 0.0;
    double globalel = 0.0;
    double globaldist = 0.0;
    double diffusion = 0.35;
    double inside = 0.0;
    double output = -6.0;
    double selected = 1.0;
    double azimuth = -30.0;
    double elevation = 0.0;
    double distance = 1.0;
    double sourcegain = 0.0;
    long mc = 0;
};

t_class* s_s3g_lbappan_class = nullptr;

void notify_attr(t_s3g_lbappan* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void notify_selected_source_attrs(t_s3g_lbappan* x)
{
    notify_attr(x, "azimuth");
    notify_attr(x, "elevation");
    notify_attr(x, "distance");
    notify_attr(x, "sourcegain");
}

void s3g_lbappan_perform64(t_s3g_lbappan* x,
                             t_object*,
                             double** ins,
                             long numins,
                             double** outs,
                             long numouts,
                             long sampleframes,
                             long,
                             void*);
void s3g_lbappan_dump(t_s3g_lbappan* x);

std::string lower_name(t_symbol* sym)
{
    std::string s = sym ? sym->s_name : "";
    for (auto& c : s) {
        c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
    }
    return s;
}

long atom_long_at(long argc, t_atom* argv, long index, long fallback)
{
    return (argv && index < argc) ? atom_getlong(argv + index) : fallback;
}

double atom_double_at(long argc, t_atom* argv, long index, double fallback)
{
    return (argv && index < argc) ? atom_getfloat(argv + index) : fallback;
}

t_symbol* atom_symbol_at(long argc, t_atom* argv, long index, t_symbol* fallback)
{
    return (argv && index < argc) ? atom_getsym(argv + index) : fallback;
}

long attr_long_arg(long argc, t_atom* argv, const char* name, long fallback)
{
    if (!argv || !name) return fallback;
    for (long i = 0; i < argc - 1; ++i) {
        if (atom_gettype(argv + i) != A_SYM) continue;
        const auto* sym = atom_getsym(argv + i);
        if (!sym || !sym->s_name || sym->s_name[0] != '@') continue;
        if (std::strcmp(sym->s_name + 1, name) == 0) {
            return atom_getlong(argv + i + 1);
        }
    }
    return fallback;
}

uint32_t index_from_one_based(double value, uint32_t maxCount)
{
    const auto rounded = static_cast<uint32_t>(std::clamp(std::floor(value + 0.5), 1.0, static_cast<double>(maxCount)));
    return rounded - 1u;
}

s3g::LayoutPannerPreset preset_from_name(t_symbol* sym, s3g::LayoutPannerPreset fallback)
{
    const auto s = lower_name(sym);
    if (s == "cube8" || s == "cube") return s3g::LayoutPannerPreset::Cube8;
    if (s == "cube17") return s3g::LayoutPannerPreset::Cube17;
    if (s == "cube41") return s3g::LayoutPannerPreset::Cube41;
    if (s == "lpac41") return s3g::LayoutPannerPreset::Lpac41;
    if (s == "dodeca12" || s == "dodeca") return s3g::LayoutPannerPreset::Dodeca12;
    if (s == "dome24" || s == "dome") return s3g::LayoutPannerPreset::Dome24NoOverhead;
    if (s == "dome25") return s3g::LayoutPannerPreset::Dome25;
    if (s == "srst25") return s3g::LayoutPannerPreset::Srst25;
    if (s == "double16" || s == "doubl16" || s == "dblring16" || s == "dbl-ring16" || s == "double-ring16") return s3g::LayoutPannerPreset::DoubleRing16;
    if (s == "double20" || s == "dblring20" || s == "dbl-ring20" || s == "double-ring20") return s3g::LayoutPannerPreset::DoubleRing20;
    if (s == "icosahedron20" || s == "icosa20" || s == "ico20") return s3g::LayoutPannerPreset::Icosahedron20;
    if (s == "octo" || s == "octo8" || s == "octophonic" || s == "octoring") return s3g::LayoutPannerPreset::OctophonicRing;
    if (s == "quad") return s3g::LayoutPannerPreset::Quad;
    if (s == "quad6" || s == "quadoh" || s == "quad+oh" || s == "quad-oh" || s == "quadoverhead") return s3g::LayoutPannerPreset::QuadOverhead6;
    if (s == "ring12") return s3g::LayoutPannerPreset::Ring12;
    if (s == "ring16" || s == "ring") return s3g::LayoutPannerPreset::Ring16;
    if (s == "5.0" || s == "fivezero" || s == "five0") return s3g::LayoutPannerPreset::FiveZero;
    if (s == "6.0" || s == "sixzero" || s == "six0") return s3g::LayoutPannerPreset::SixZero;
    if (s == "7.0" || s == "sevenzero" || s == "seven0") return s3g::LayoutPannerPreset::SevenZero;
    if (s == "5.0.2" || s == "fivezerotwo" || s == "five02") return s3g::LayoutPannerPreset::FiveZeroTwo;
    if (s == "7.0.2" || s == "sevenzerotwo" || s == "seven02") return s3g::LayoutPannerPreset::SevenZeroTwo;
    if (s == "5.0.4" || s == "fivezerofour" || s == "five04") return s3g::LayoutPannerPreset::FiveZeroFour;
    if (s == "7.0.4" || s == "7.0.4." || s == "sevenzerofour" || s == "seven04") return s3g::LayoutPannerPreset::SevenZeroFour;
    if (s == "9.0" || s == "ninezero" || s == "nine0") return s3g::LayoutPannerPreset::NineZero;
    if (s == "9.0.2" || s == "ninezerotwo" || s == "nine02") return s3g::LayoutPannerPreset::NineZeroTwo;
    if (s == "9.0.4" || s == "ninezerofour" || s == "nine04") return s3g::LayoutPannerPreset::NineZeroFour;
    if (s == "9.0.6" || s == "ninezerosix" || s == "nine06") return s3g::LayoutPannerPreset::NineZeroSix;
    if (s == "7.0.6" || s == "sevenzerosix" || s == "seven06") return s3g::LayoutPannerPreset::SevenZeroSix;
    if (s == "11.0.8" || s == "elevenzeroeight" || s == "eleven08") return s3g::LayoutPannerPreset::ElevenZeroEight;
    return fallback;
}

constexpr std::array<s3g::LayoutPannerPreset, 29> kCuratedLayouts {
    s3g::LayoutPannerPreset::Cube8,
    s3g::LayoutPannerPreset::Cube17,
    s3g::LayoutPannerPreset::Dodeca12,
    s3g::LayoutPannerPreset::Dome24NoOverhead,
    s3g::LayoutPannerPreset::Dome25,
    s3g::LayoutPannerPreset::DoubleRing16,
    s3g::LayoutPannerPreset::DoubleRing20,
    s3g::LayoutPannerPreset::OctophonicRing,
    s3g::LayoutPannerPreset::Quad,
    s3g::LayoutPannerPreset::QuadOverhead6,
    s3g::LayoutPannerPreset::Ring12,
    s3g::LayoutPannerPreset::Ring16,
    s3g::LayoutPannerPreset::FiveZero,
    s3g::LayoutPannerPreset::SixZero,
    s3g::LayoutPannerPreset::SevenZero,
    s3g::LayoutPannerPreset::FiveZeroTwo,
    s3g::LayoutPannerPreset::SevenZeroTwo,
    s3g::LayoutPannerPreset::FiveZeroFour,
    s3g::LayoutPannerPreset::SevenZeroFour,
    s3g::LayoutPannerPreset::NineZero,
    s3g::LayoutPannerPreset::NineZeroTwo,
    s3g::LayoutPannerPreset::NineZeroFour,
    s3g::LayoutPannerPreset::NineZeroSix,
    s3g::LayoutPannerPreset::SevenZeroSix,
    s3g::LayoutPannerPreset::ElevenZeroEight,
    s3g::LayoutPannerPreset::Icosahedron20,
    s3g::LayoutPannerPreset::Cube41,
    s3g::LayoutPannerPreset::Lpac41,
    s3g::LayoutPannerPreset::Srst25,
};

s3g::LayoutPannerPreset preset_from_index(long index, s3g::LayoutPannerPreset fallback)
{
    if (index < 0 || index >= static_cast<long>(kCuratedLayouts.size())) return fallback;
    return kCuratedLayouts[static_cast<size_t>(index)];
}

uint32_t index_for_preset(s3g::LayoutPannerPreset preset)
{
    for (uint32_t i = 0; i < kCuratedLayouts.size(); ++i) {
        if (kCuratedLayouts[i] == preset) return i;
    }
    return 0u;
}

const char* preset_symbol_name(s3g::LayoutPannerPreset preset)
{
    switch (preset) {
    case s3g::LayoutPannerPreset::Custom: return "custom";
    case s3g::LayoutPannerPreset::Cube8: return "cube8";
    case s3g::LayoutPannerPreset::Cube17: return "cube17";
    case s3g::LayoutPannerPreset::Cube41: return "cube41";
    case s3g::LayoutPannerPreset::Lpac41: return "lpac41";
    case s3g::LayoutPannerPreset::Dodeca12: return "dodeca12";
    case s3g::LayoutPannerPreset::Dome24NoOverhead: return "dome24";
    case s3g::LayoutPannerPreset::Dome25: return "dome25";
    case s3g::LayoutPannerPreset::Srst25: return "srst25";
    case s3g::LayoutPannerPreset::DoubleRing16: return "double16";
    case s3g::LayoutPannerPreset::DoubleRing20: return "double20";
    case s3g::LayoutPannerPreset::Icosahedron20: return "icosahedron20";
    case s3g::LayoutPannerPreset::OctophonicRing: return "octo";
    case s3g::LayoutPannerPreset::Quad: return "quad";
    case s3g::LayoutPannerPreset::QuadOverhead6: return "quad+oh";
    case s3g::LayoutPannerPreset::Ring12: return "ring12";
    case s3g::LayoutPannerPreset::Ring16: return "ring16";
    case s3g::LayoutPannerPreset::FiveZero: return "5.0";
    case s3g::LayoutPannerPreset::SixZero: return "6.0";
    case s3g::LayoutPannerPreset::SevenZero: return "7.0";
    case s3g::LayoutPannerPreset::FiveZeroTwo: return "5.0.2";
    case s3g::LayoutPannerPreset::SevenZeroTwo: return "7.0.2";
    case s3g::LayoutPannerPreset::FiveZeroFour: return "5.0.4";
    case s3g::LayoutPannerPreset::SevenZeroFour: return "7.0.4";
    case s3g::LayoutPannerPreset::NineZero: return "9.0";
    case s3g::LayoutPannerPreset::NineZeroTwo: return "9.0.2";
    case s3g::LayoutPannerPreset::NineZeroFour: return "9.0.4";
    case s3g::LayoutPannerPreset::NineZeroSix: return "9.0.6";
    case s3g::LayoutPannerPreset::SevenZeroSix: return "7.0.6";
    case s3g::LayoutPannerPreset::ElevenZeroEight: return "11.0.8";
    default: return "dome24";
    }
}

const char* method_symbol_name(s3g::LayoutPannerMethod method)
{
    return method == s3g::LayoutPannerMethod::Lbap ? "lbap" : (method == s3g::LayoutPannerMethod::Cosine ? "cos" : "dist");
}

s3g::LayoutPannerMethod method_from_name(t_symbol* sym, s3g::LayoutPannerMethod fallback)
{
    const auto s = lower_name(sym);
    if (s == "dist" || s == "distance") return s3g::LayoutPannerMethod::Distance;
    if (s == "cos" || s == "cosine") return s3g::LayoutPannerMethod::Cosine;
    return fallback;
}

s3g::LayoutPannerMethod method_from_index(long index, s3g::LayoutPannerMethod fallback)
{
    if (index < 0 || index > 1) return fallback;
    return static_cast<s3g::LayoutPannerMethod>(static_cast<uint32_t>(index));
}

void sync_attrs(t_s3g_lbappan* x)
{
    if (!x || !x->impl) return;
    const auto p = x->impl->panner.params();
    const auto source = x->impl->panner.source(p.selectedSource);
    x->impl->params = p;
    x->layout = static_cast<double>(index_for_preset(p.layout));
    x->method = static_cast<double>(static_cast<uint32_t>(p.method));
    x->focus = p.focus;
    x->rolloff = p.distanceRolloffDb;
    x->smooth = p.smoothingMs;
    x->globalaz = p.globalAzimuthDeg;
    x->globalel = p.globalElevationDeg;
    x->globaldist = p.globalDistanceOffset;
    x->diffusion = p.distanceDiffusion;
    x->inside = static_cast<double>(static_cast<uint32_t>(p.insideMode));
    x->output = p.outputGainDb;
    x->selected = static_cast<double>(p.selectedSource + 1u);
    x->azimuth = source.azimuthDeg;
    x->elevation = source.elevationDeg;
    x->distance = source.distance;
    x->sourcegain = source.gainDb;
}

void apply_params(t_s3g_lbappan* x)
{
    if (!x || !x->impl) return;
    x->impl->params.method = s3g::LayoutPannerMethod::Lbap;
    x->impl->panner.setParams(x->impl->params);
    sync_attrs(x);
    s3g_lbappan_dump(x);
}

void prepare(t_s3g_lbappan* x, double sampleRate)
{
    if (!x || !x->impl) return;
    x->impl->sampleRate = std::max(1.0, sampleRate);
    x->impl->panner.prepare(x->impl->sampleRate);
    x->impl->params.method = s3g::LayoutPannerMethod::Lbap;
    x->impl->panner.setParams(x->impl->params);
    x->impl->prepared = true;
    sync_attrs(x);
}

void set_layout(t_s3g_lbappan* x, s3g::LayoutPannerPreset preset)
{
    if (index_for_preset(preset) == 0u && preset != kCuratedLayouts[0]) {
        preset = s3g::LayoutPannerPreset::Dome24NoOverhead;
    }
    x->impl->params.layout = preset;
    apply_params(x);
    notify_attr(x, "layout");
}

void set_method(t_s3g_lbappan* x, s3g::LayoutPannerMethod method)
{
    x->impl->params.method = method;
    apply_params(x);
    notify_attr(x, "method");
}

void set_focus(t_s3g_lbappan* x, double v) { x->impl->params.focus = static_cast<float>(v); apply_params(x); notify_attr(x, "focus"); }
void set_rolloff(t_s3g_lbappan* x, double v) { x->impl->params.distanceRolloffDb = static_cast<float>(v); apply_params(x); notify_attr(x, "rolloff"); }
void set_smooth(t_s3g_lbappan* x, double v) { x->impl->params.smoothingMs = static_cast<float>(v); apply_params(x); notify_attr(x, "smooth"); }
void set_globalaz(t_s3g_lbappan* x, double v) { x->impl->params.globalAzimuthDeg = static_cast<float>(v); apply_params(x); notify_attr(x, "globalaz"); }
void set_globalel(t_s3g_lbappan* x, double v) { x->impl->params.globalElevationDeg = static_cast<float>(v); apply_params(x); notify_attr(x, "globalel"); }
void set_globaldist(t_s3g_lbappan* x, double v) { x->impl->params.globalDistanceOffset = static_cast<float>(v); apply_params(x); notify_attr(x, "globaldist"); }
void set_diffusion(t_s3g_lbappan* x, double v) { x->impl->params.distanceDiffusion = static_cast<float>(v); apply_params(x); notify_attr(x, "diffusion"); }
void set_inside(t_s3g_lbappan* x, double v) { x->impl->params.insideMode = static_cast<s3g::LayoutPannerInsideMode>(std::clamp<long>(static_cast<long>(std::lround(v)), 0, 3)); apply_params(x); notify_attr(x, "inside"); }
void set_output(t_s3g_lbappan* x, double v) { x->impl->params.outputGainDb = static_cast<float>(v); apply_params(x); notify_attr(x, "output"); }

void set_selected(t_s3g_lbappan* x, double v)
{
    x->impl->params.selectedSource = index_from_one_based(v, kMaxInputs);
    apply_params(x);
    notify_attr(x, "selected");
    notify_selected_source_attrs(x);
}

void set_selected_source_aed(t_s3g_lbappan* x, double az, double el, double dist, double gain)
{
    const auto sourceIndex = x->impl->params.selectedSource;
    auto source = x->impl->panner.source(sourceIndex);
    source.azimuthDeg = static_cast<float>(az);
    source.elevationDeg = static_cast<float>(el);
    source.distance = static_cast<float>(dist);
    source.gainDb = static_cast<float>(gain);
    x->impl->panner.setSource(sourceIndex, source);
    sync_attrs(x);
    s3g_lbappan_dump(x);
    notify_selected_source_attrs(x);
}

void s3g_lbappan_layout(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return;
    const auto current = x->impl->params.layout;
    if (atom_gettype(argv) == A_SYM) {
        set_layout(x, preset_from_name(atom_getsym(argv), current));
    } else {
        set_layout(x, preset_from_index(atom_getlong(argv), current));
    }
}

void s3g_lbappan_method(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return;
    const auto current = x->impl->params.method;
    if (atom_gettype(argv) == A_SYM) {
        set_method(x, method_from_name(atom_getsym(argv), current));
    } else {
        set_method(x, method_from_index(atom_getlong(argv), current));
    }
}

void s3g_lbappan_focus(t_s3g_lbappan* x, double v) { set_focus(x, v); }
void s3g_lbappan_rolloff(t_s3g_lbappan* x, double v) { set_rolloff(x, v); }
void s3g_lbappan_smooth(t_s3g_lbappan* x, double v) { set_smooth(x, v); }
void s3g_lbappan_globalaz(t_s3g_lbappan* x, double v) { set_globalaz(x, v); }
void s3g_lbappan_globalel(t_s3g_lbappan* x, double v) { set_globalel(x, v); }
void s3g_lbappan_globaldist(t_s3g_lbappan* x, double v) { set_globaldist(x, v); }
void s3g_lbappan_diffusion(t_s3g_lbappan* x, double v) { set_diffusion(x, v); }
void s3g_lbappan_inside(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return;
    if (atom_gettype(argv) == A_SYM) {
        const auto s = lower_name(atom_getsym(argv));
        if (s == "hold") set_inside(x, 0.0);
        else if (s == "attenuate" || s == "atten") set_inside(x, 1.0);
        else if (s == "diffuse") set_inside(x, 2.0);
        else if (s == "center" || s == "centre" || s == "blend" || s == "centerblend") set_inside(x, 3.0);
    } else {
        set_inside(x, atom_getlong(argv));
    }
}
void s3g_lbappan_output(t_s3g_lbappan* x, double v) { set_output(x, v); }
void s3g_lbappan_select(t_s3g_lbappan* x, double v) { set_selected(x, v); }
void s3g_lbappan_azimuth(t_s3g_lbappan* x, double v) { set_selected_source_aed(x, v, x->elevation, x->distance, x->sourcegain); }
void s3g_lbappan_elevation(t_s3g_lbappan* x, double v) { set_selected_source_aed(x, x->azimuth, v, x->distance, x->sourcegain); }
void s3g_lbappan_distance(t_s3g_lbappan* x, double v) { set_selected_source_aed(x, x->azimuth, x->elevation, v, x->sourcegain); }
void s3g_lbappan_sourcegain(t_s3g_lbappan* x, double v) { set_selected_source_aed(x, x->azimuth, x->elevation, x->distance, v); }

void s3g_lbappan_source(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 4) {
        object_error(reinterpret_cast<t_object*>(x), "source expects: source <1-64> <az> <el> <dist> [gain]");
        return;
    }
    const auto index = index_from_one_based(atom_double_at(argc, argv, 0, 1.0), kMaxInputs);
    auto source = x->impl->panner.source(index);
    source.azimuthDeg = static_cast<float>(atom_double_at(argc, argv, 1, source.azimuthDeg));
    source.elevationDeg = static_cast<float>(atom_double_at(argc, argv, 2, source.elevationDeg));
    source.distance = static_cast<float>(atom_double_at(argc, argv, 3, source.distance));
    source.gainDb = static_cast<float>(atom_double_at(argc, argv, 4, source.gainDb));
    x->impl->panner.setSource(index, source);
    sync_attrs(x);
    s3g_lbappan_dump(x);
}

void s3g_lbappan_sourcexyz(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 4) {
        object_error(reinterpret_cast<t_object*>(x), "sourcexyz expects: sourcexyz <1-64> <x> <y> <z> [gain]");
        return;
    }
    const auto index = index_from_one_based(atom_double_at(argc, argv, 0, 1.0), kMaxInputs);
    x->impl->panner.setSourcePosition(index, {
        static_cast<float>(atom_double_at(argc, argv, 1, 1.0)),
        static_cast<float>(atom_double_at(argc, argv, 2, 0.0)),
        static_cast<float>(atom_double_at(argc, argv, 3, 0.0))
    });
    if (argc > 4) {
        x->impl->panner.setSourceGain(index, static_cast<float>(atom_double_at(argc, argv, 4, 0.0)));
    }
    sync_attrs(x);
    s3g_lbappan_dump(x);
}

void s3g_lbappan_sourcegain_msg(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 2) return;
    x->impl->panner.setSourceGain(index_from_one_based(atom_double_at(argc, argv, 0, 1.0), kMaxInputs),
                                  static_cast<float>(atom_double_at(argc, argv, 1, 0.0)));
    sync_attrs(x);
    s3g_lbappan_dump(x);
}

void s3g_lbappan_mute(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 2) return;
    x->impl->panner.setSourceMute(index_from_one_based(atom_double_at(argc, argv, 0, 1.0), kMaxInputs),
                                  atom_double_at(argc, argv, 1, 0.0) != 0.0);
    sync_attrs(x);
    s3g_lbappan_dump(x);
}

void s3g_lbappan_solo(t_s3g_lbappan* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 2) return;
    x->impl->panner.setSourceSolo(index_from_one_based(atom_double_at(argc, argv, 0, 1.0), kMaxInputs),
                                  atom_double_at(argc, argv, 1, 0.0) != 0.0);
    sync_attrs(x);
    s3g_lbappan_dump(x);
}

void s3g_lbappan_dump(t_s3g_lbappan* x)
{
    if (!x || !x->impl || !x->infoOutlet) return;
    sync_attrs(x);
    const auto p = x->impl->panner.params();
    t_atom atoms[10];
    atom_setlong(atoms, x->impl->inputCount);
    atom_setlong(atoms + 1, x->impl->outputCount);
    atom_setlong(atoms + 2, static_cast<long>(p.activeSpeakers));
    outlet_anything(x->infoOutlet, gensym("config"), 3, atoms);

    atom_setlong(atoms, static_cast<long>(static_cast<uint32_t>(p.layout)));
    atom_setsym(atoms + 1, gensym(preset_symbol_name(p.layout)));
    outlet_anything(x->infoOutlet, gensym("layout"), 2, atoms);

    atom_setlong(atoms, static_cast<long>(static_cast<uint32_t>(p.method)));
    atom_setsym(atoms + 1, gensym(method_symbol_name(p.method)));
    outlet_anything(x->infoOutlet, gensym("method"), 2, atoms);

    atom_setfloat(atoms, p.focus);
    atom_setfloat(atoms + 1, p.distanceRolloffDb);
    atom_setfloat(atoms + 2, p.smoothingMs);
    atom_setfloat(atoms + 3, p.globalAzimuthDeg);
    atom_setfloat(atoms + 4, p.globalElevationDeg);
    atom_setfloat(atoms + 5, p.globalDistanceOffset);
    atom_setfloat(atoms + 6, p.distanceDiffusion);
    atom_setlong(atoms + 7, static_cast<long>(static_cast<uint32_t>(p.insideMode)));
    atom_setfloat(atoms + 8, p.outputGainDb);
    atom_setlong(atoms + 9, static_cast<long>(p.selectedSource + 1u));
    outlet_anything(x->infoOutlet, gensym("params"), 10, atoms);

    for (uint32_t i = 0; i < std::min<uint32_t>(p.activeSpeakers, kMaxOutputs); ++i) {
        const auto sp = x->impl->panner.speaker(i);
        atom_setlong(atoms, static_cast<long>(i + 1u));
        atom_setfloat(atoms + 1, sp.azimuthDeg);
        atom_setfloat(atoms + 2, sp.elevationDeg);
        atom_setfloat(atoms + 3, sp.distance);
        outlet_anything(x->infoOutlet, gensym("speaker"), 4, atoms);
    }
    for (uint32_t i = 0; i < std::min<uint32_t>(p.activeSources, kMaxInputs); ++i) {
        const auto src = x->impl->panner.source(i);
        atom_setlong(atoms, static_cast<long>(i + 1u));
        atom_setfloat(atoms + 1, src.azimuthDeg);
        atom_setfloat(atoms + 2, src.elevationDeg);
        atom_setfloat(atoms + 3, src.distance);
        atom_setfloat(atoms + 4, src.gainDb);
        atom_setlong(atoms + 5, src.muted ? 1 : 0);
        atom_setlong(atoms + 6, src.solo ? 1 : 0);
        atom_setfloat(atoms + 7, src.x);
        atom_setfloat(atoms + 8, src.y);
        atom_setfloat(atoms + 9, src.z);
        outlet_anything(x->infoOutlet, gensym("source"), 10, atoms);
    }
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

t_max_err attr_layout_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return MAX_ERR_NONE;
    if (atom_gettype(argv) == A_SYM) {
        set_layout(x, preset_from_name(atom_getsym(argv), x->impl->params.layout));
    } else {
        set_layout(x, preset_from_index(atom_getlong(argv), x->impl->params.layout));
    }
    return MAX_ERR_NONE;
}

t_max_err attr_method_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return MAX_ERR_NONE;
    if (atom_gettype(argv) == A_SYM) {
        set_method(x, method_from_name(atom_getsym(argv), x->impl->params.method));
    } else {
        const auto v = static_cast<uint32_t>(std::clamp(atom_getlong(argv), 0L, 1L));
        set_method(x, static_cast<s3g::LayoutPannerMethod>(v));
    }
    return MAX_ERR_NONE;
}

t_max_err attr_focus_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_focus(x, atom_double_at(argc, argv, 0, x->focus)); return MAX_ERR_NONE; }
t_max_err attr_rolloff_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_rolloff(x, atom_double_at(argc, argv, 0, x->rolloff)); return MAX_ERR_NONE; }
t_max_err attr_smooth_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_smooth(x, atom_double_at(argc, argv, 0, x->smooth)); return MAX_ERR_NONE; }
t_max_err attr_globalaz_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_globalaz(x, atom_double_at(argc, argv, 0, x->globalaz)); return MAX_ERR_NONE; }
t_max_err attr_globalel_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_globalel(x, atom_double_at(argc, argv, 0, x->globalel)); return MAX_ERR_NONE; }
t_max_err attr_globaldist_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_globaldist(x, atom_double_at(argc, argv, 0, x->globaldist)); return MAX_ERR_NONE; }
t_max_err attr_diffusion_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_diffusion(x, atom_double_at(argc, argv, 0, x->diffusion)); return MAX_ERR_NONE; }
t_max_err attr_inside_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_inside(x, atom_double_at(argc, argv, 0, x->inside)); return MAX_ERR_NONE; }
t_max_err attr_output_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_selected_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { set_selected(x, atom_double_at(argc, argv, 0, x->selected)); return MAX_ERR_NONE; }
t_max_err attr_azimuth_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { s3g_lbappan_azimuth(x, atom_double_at(argc, argv, 0, x->azimuth)); return MAX_ERR_NONE; }
t_max_err attr_elevation_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { s3g_lbappan_elevation(x, atom_double_at(argc, argv, 0, x->elevation)); return MAX_ERR_NONE; }
t_max_err attr_distance_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { s3g_lbappan_distance(x, atom_double_at(argc, argv, 0, x->distance)); return MAX_ERR_NONE; }
t_max_err attr_sourcegain_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv) { s3g_lbappan_sourcegain(x, atom_double_at(argc, argv, 0, x->sourcegain)); return MAX_ERR_NONE; }

t_max_err attr_mc_set(t_s3g_lbappan* x, void*, long argc, t_atom* argv)
{
    const long requested = atom_long_at(argc, argv, 0, x ? x->mc : 0) != 0 ? 1 : 0;
    if (x && x->impl && x->impl->prepared && requested != x->mc) {
        object_warn(reinterpret_cast<t_object*>(x), "mc is construction-time only; recreate object to change MC mode");
        return MAX_ERR_NONE;
    }
    if (x) x->mc = requested;
    return MAX_ERR_NONE;
}

void s3g_lbappan_dsp64(t_s3g_lbappan* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x->impl->prepared || sampleRate != x->impl->sampleRate) {
        prepare(x, sampleRate);
    }
    object_method(dsp64, gensym("dsp_add64"), x, s3g_lbappan_perform64, 0, nullptr);
}

void s3g_lbappan_perform64(t_s3g_lbappan* x, t_object*, double** ins, long numins, double** outs, long numouts, long sampleframes, long, void*)
{
    if (!x || !x->impl) return;
    if (!x->impl->prepared) {
        prepare(x, x->impl->sampleRate);
    }
    const long inCount = std::min<long>({ x->impl->inputCount, numins, kMaxInputs });
    const long outCount = std::min<long>({ x->impl->outputCount, numouts, kMaxOutputs });
    if (x->impl->panner.canProcessQuadOverhead2x6(static_cast<uint32_t>(inCount), static_cast<uint32_t>(outCount))) {
        x->impl->panner.processQuadOverhead2x6Block(ins, outs, static_cast<uint32_t>(sampleframes));
        return;
    }
    if (x->impl->panner.canProcessPresetLayoutKernel(static_cast<uint32_t>(inCount), static_cast<uint32_t>(outCount))) {
        x->impl->panner.processPresetLayoutBlock(ins,
                                                 outs,
                                                 static_cast<uint32_t>(inCount),
                                                 static_cast<uint32_t>(outCount),
                                                 static_cast<uint32_t>(sampleframes));
        return;
    }
    x->impl->panner.beginVector(static_cast<uint32_t>(inCount),
                                static_cast<uint32_t>(outCount),
                                static_cast<uint32_t>(sampleframes));
    for (long i = 0; i < sampleframes; ++i) {
        for (long ch = 0; ch < inCount; ++ch) {
            x->impl->frameIn[static_cast<size_t>(ch)] = ins[ch] ? static_cast<float>(ins[ch][i]) : 0.0f;
        }
        x->impl->panner.processVectorFrame(x->impl->frameIn.data(), x->impl->frameOut.data());
        for (long ch = 0; ch < outCount; ++ch) {
            if (outs[ch]) outs[ch][i] = x->impl->frameOut[static_cast<size_t>(ch)];
        }
        for (long ch = outCount; ch < numouts; ++ch) {
            if (outs[ch]) outs[ch][i] = 0.0;
        }
    }
}

void s3g_lbappan_assist(t_s3g_lbappan* x, void*, long message, long index, char* text)
{
    if (message == ASSIST_INLET) {
        if (x && x->mc) {
            snprintf_zero(text, 256, "MC signal source input / parameter messages");
        } else {
            snprintf_zero(text, 256, "Signal source input %ld / parameter messages", index + 1);
        }
    } else if (x && x->mc && index == 0) {
        snprintf_zero(text, 256, "MC signal speaker output");
    } else if (index < x->impl->outputCount) {
        snprintf_zero(text, 256, "Signal speaker output %ld", index + 1);
    } else {
        snprintf_zero(text, 256, "Info outlet");
    }
}

long s3g_lbappan_multichanneloutputs(t_s3g_lbappan* x, long index)
{
    if (!x || !x->mc || index != 0 || !x->impl) return 0;
    return x->impl->outputCount;
}

long s3g_lbappan_inputchanged(t_s3g_lbappan* x, long, long)
{
    (void)x;
    return false;
}

void* s3g_lbappan_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_lbappan*>(object_alloc(s_s3g_lbappan_class));
    if (!x) return nullptr;

    x->impl = new LbapPanImpl();
    x->impl->inputCount = std::clamp(atom_long_at(argc, argv, 0, kDefaultInputs), 1L, kMaxInputs);
    x->impl->outputCount = std::clamp(atom_long_at(argc, argv, 1, kDefaultOutputs), 2L, kMaxOutputs);
    x->mc = attr_long_arg(argc, argv, "mc", 0) != 0 ? 1 : 0;

    auto layoutSym = atom_symbol_at(argc, argv, 2, gensym("dome24"));
    x->impl->params.layout = preset_from_name(layoutSym, s3g::LayoutPannerPreset::Dome24NoOverhead);
    x->impl->params.method = s3g::LayoutPannerMethod::Lbap;
    x->impl->params.activeSources = static_cast<uint32_t>(x->impl->inputCount);
    x->impl->params.activeSpeakers = static_cast<uint32_t>(x->impl->outputCount);

    x->infoOutlet = outlet_new(reinterpret_cast<t_object*>(x), nullptr);
    if (x->mc) {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), 1);
        x->object.z_misc |= Z_NO_INPLACE | Z_MC_INLETS;
        outlet_new(reinterpret_cast<t_object*>(x), "multichannelsignal");
    } else {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), x->impl->inputCount);
        for (long i = 0; i < x->impl->outputCount; ++i) {
            outlet_new(reinterpret_cast<t_object*>(x), "signal");
        }
    }

    x->impl->params.method = s3g::LayoutPannerMethod::Lbap;
    x->impl->panner.setParams(x->impl->params);
    sync_attrs(x);
    attr_args_process(x, argc, argv);
    prepare(x, sys_getsr());
    return x;
}

void s3g_lbappan_free(t_s3g_lbappan* x)
{
    dsp_free(reinterpret_cast<t_pxobject*>(x));
    delete x->impl;
    x->impl = nullptr;
}

} // namespace

extern "C" void ext_main(void* r)
{
    t_class* c = class_new("s3g.lbappan~",
                           reinterpret_cast<method>(s3g_lbappan_new),
                           reinterpret_cast<method>(s3g_lbappan_free),
                           sizeof(t_s3g_lbappan),
                           nullptr,
                           A_GIMME,
                           0);

    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_layout), "layout", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_focus), "focus", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_rolloff), "rolloff", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_smooth), "smooth", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_globalaz), "globalaz", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_globalel), "globalel", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_globaldist), "globaldist", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_diffusion), "diffusion", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_inside), "inside", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_select), "select", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_select), "selected", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_azimuth), "azimuth", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_elevation), "elevation", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_distance), "distance", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_sourcegain), "sourcegain", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_source), "source", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_sourcexyz), "sourcexyz", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_sourcegain_msg), "srcgain", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_mute), "mute", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_solo), "solo", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_lbappan_dump), "dump", 0);

    CLASS_ATTR_DOUBLE(c, "layout", 0, t_s3g_lbappan, layout);
    CLASS_ATTR_ACCESSORS(c, "layout", nullptr, attr_layout_set);
    CLASS_ATTR_ENUMINDEX(c, "layout", 0, "cube8 cube17 dodeca12 dome24 dome25 double16 double20 octo quad quad+oh ring12 ring16 5.0 6.0 7.0 5.0.2 7.0.2 5.0.4 7.0.4 9.0 9.0.2 9.0.4 9.0.6 7.0.6 11.0.8 icosahedron20 cube41 lpac41 srst25");
    CLASS_ATTR_FILTER_CLIP(c, "layout", 0, 28);
    CLASS_ATTR_LABEL(c, "layout", 0, "Layout");
    CLASS_ATTR_DOUBLE(c, "focus", 0, t_s3g_lbappan, focus);
    CLASS_ATTR_ACCESSORS(c, "focus", nullptr, attr_focus_set);
    CLASS_ATTR_FILTER_CLIP(c, "focus", 0.25, 4.0);
    CLASS_ATTR_LABEL(c, "focus", 0, "Focus");
    CLASS_ATTR_DOUBLE(c, "rolloff", 0, t_s3g_lbappan, rolloff);
    CLASS_ATTR_ACCESSORS(c, "rolloff", nullptr, attr_rolloff_set);
    CLASS_ATTR_FILTER_CLIP(c, "rolloff", 0.0, 48.0);
    CLASS_ATTR_LABEL(c, "rolloff", 0, "Distance Rolloff dB");
    CLASS_ATTR_DOUBLE(c, "smooth", 0, t_s3g_lbappan, smooth);
    CLASS_ATTR_ACCESSORS(c, "smooth", nullptr, attr_smooth_set);
    CLASS_ATTR_FILTER_CLIP(c, "smooth", 1.0, 250.0);
    CLASS_ATTR_LABEL(c, "smooth", 0, "Smoothing ms");
    CLASS_ATTR_DOUBLE(c, "globalaz", 0, t_s3g_lbappan, globalaz);
    CLASS_ATTR_ACCESSORS(c, "globalaz", nullptr, attr_globalaz_set);
    CLASS_ATTR_FILTER_CLIP(c, "globalaz", -180.0, 180.0);
    CLASS_ATTR_LABEL(c, "globalaz", 0, "Global Azimuth");
    CLASS_ATTR_DOUBLE(c, "globalel", 0, t_s3g_lbappan, globalel);
    CLASS_ATTR_ACCESSORS(c, "globalel", nullptr, attr_globalel_set);
    CLASS_ATTR_FILTER_CLIP(c, "globalel", -90.0, 90.0);
    CLASS_ATTR_LABEL(c, "globalel", 0, "Global Elevation");
    CLASS_ATTR_DOUBLE(c, "globaldist", 0, t_s3g_lbappan, globaldist);
    CLASS_ATTR_ACCESSORS(c, "globaldist", nullptr, attr_globaldist_set);
    CLASS_ATTR_FILTER_CLIP(c, "globaldist", -3.0, 3.0);
    CLASS_ATTR_LABEL(c, "globaldist", 0, "Global Distance Offset");
    CLASS_ATTR_DOUBLE(c, "diffusion", 0, t_s3g_lbappan, diffusion);
    CLASS_ATTR_ACCESSORS(c, "diffusion", nullptr, attr_diffusion_set);
    CLASS_ATTR_FILTER_CLIP(c, "diffusion", 0.0, 1.0);
    CLASS_ATTR_LABEL(c, "diffusion", 0, "Distance Diffusion");
    CLASS_ATTR_DOUBLE(c, "inside", 0, t_s3g_lbappan, inside);
    CLASS_ATTR_ACCESSORS(c, "inside", nullptr, attr_inside_set);
    CLASS_ATTR_ENUMINDEX(c, "inside", 0, "hold attenuate diffuse center");
    CLASS_ATTR_FILTER_CLIP(c, "inside", 0, 3);
    CLASS_ATTR_LABEL(c, "inside", 0, "Inside Mode");
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_lbappan, output);
    CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output_set);
    CLASS_ATTR_FILTER_CLIP(c, "output", -60.0, 12.0);
    CLASS_ATTR_LABEL(c, "output", 0, "Output Gain dB");
    CLASS_ATTR_DOUBLE(c, "selected", 0, t_s3g_lbappan, selected);
    CLASS_ATTR_ACCESSORS(c, "selected", nullptr, attr_selected_set);
    CLASS_ATTR_FILTER_CLIP(c, "selected", 1, 64);
    CLASS_ATTR_LABEL(c, "selected", 0, "Selected Source");
    CLASS_ATTR_DOUBLE(c, "azimuth", 0, t_s3g_lbappan, azimuth);
    CLASS_ATTR_ACCESSORS(c, "azimuth", nullptr, attr_azimuth_set);
    CLASS_ATTR_FILTER_CLIP(c, "azimuth", -180.0, 180.0);
    CLASS_ATTR_LABEL(c, "azimuth", 0, "Source Azimuth");
    CLASS_ATTR_DOUBLE(c, "elevation", 0, t_s3g_lbappan, elevation);
    CLASS_ATTR_ACCESSORS(c, "elevation", nullptr, attr_elevation_set);
    CLASS_ATTR_FILTER_CLIP(c, "elevation", -90.0, 90.0);
    CLASS_ATTR_LABEL(c, "elevation", 0, "Source Elevation");
    CLASS_ATTR_DOUBLE(c, "distance", 0, t_s3g_lbappan, distance);
    CLASS_ATTR_ACCESSORS(c, "distance", nullptr, attr_distance_set);
    CLASS_ATTR_FILTER_CLIP(c, "distance", 0.1, 3.0);
    CLASS_ATTR_LABEL(c, "distance", 0, "Source Distance");
    CLASS_ATTR_DOUBLE(c, "sourcegain", 0, t_s3g_lbappan, sourcegain);
    CLASS_ATTR_ACCESSORS(c, "sourcegain", nullptr, attr_sourcegain_set);
    CLASS_ATTR_FILTER_CLIP(c, "sourcegain", -60.0, 24.0);
    CLASS_ATTR_LABEL(c, "sourcegain", 0, "Source Gain dB");
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_lbappan, mc);
    CLASS_ATTR_ACCESSORS(c, "mc", nullptr, attr_mc_set);
    CLASS_ATTR_FILTER_CLIP(c, "mc", 0, 1);
    CLASS_ATTR_LABEL(c, "mc", 0, "MC Mode");

    CLASS_ATTR_DEFAULT(c, "layout", 0, "12"); CLASS_ATTR_SAVE(c, "layout", 0);
    CLASS_ATTR_DEFAULT(c, "focus", 0, "1."); CLASS_ATTR_SAVE(c, "focus", 0);
    CLASS_ATTR_DEFAULT(c, "rolloff", 0, "6."); CLASS_ATTR_SAVE(c, "rolloff", 0);
    CLASS_ATTR_DEFAULT(c, "smooth", 0, "35."); CLASS_ATTR_SAVE(c, "smooth", 0);
    CLASS_ATTR_DEFAULT(c, "globalaz", 0, "0."); CLASS_ATTR_SAVE(c, "globalaz", 0);
    CLASS_ATTR_DEFAULT(c, "globalel", 0, "0."); CLASS_ATTR_SAVE(c, "globalel", 0);
    CLASS_ATTR_DEFAULT(c, "globaldist", 0, "0."); CLASS_ATTR_SAVE(c, "globaldist", 0);
    CLASS_ATTR_DEFAULT(c, "diffusion", 0, "0.35"); CLASS_ATTR_SAVE(c, "diffusion", 0);
    CLASS_ATTR_DEFAULT(c, "inside", 0, "0"); CLASS_ATTR_SAVE(c, "inside", 0);
    CLASS_ATTR_DEFAULT(c, "output", 0, "-6."); CLASS_ATTR_SAVE(c, "output", 0);
    CLASS_ATTR_DEFAULT(c, "selected", 0, "1"); CLASS_ATTR_SAVE(c, "selected", 0);
    CLASS_ATTR_DEFAULT(c, "azimuth", 0, "-30."); CLASS_ATTR_SAVE(c, "azimuth", 0);
    CLASS_ATTR_DEFAULT(c, "elevation", 0, "0."); CLASS_ATTR_SAVE(c, "elevation", 0);
    CLASS_ATTR_DEFAULT(c, "distance", 0, "1."); CLASS_ATTR_SAVE(c, "distance", 0);
    CLASS_ATTR_DEFAULT(c, "sourcegain", 0, "0."); CLASS_ATTR_SAVE(c, "sourcegain", 0);
    CLASS_ATTR_DEFAULT(c, "mc", 0, "0"); CLASS_ATTR_SAVE(c, "mc", 0);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_s3g_lbappan_class = c;
    post("s3g.lbappan~: wrapping s3g::LayoutPanner from s3g-dsp");
    (void)r;
}
