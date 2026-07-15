#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_sub_crossover.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cstdint>
#include <new>
#include <string>

namespace {

constexpr long kDefaultChannels = 6;
constexpr long kMaxChannels = s3g::kSubCrossoverMaxChannels;

struct SubXoverImpl {
    s3g::SubCrossover xover;
    s3g::SubCrossoverParams params;
    std::array<float, kMaxChannels> frameIn {};
    std::array<float, kMaxChannels> frameOut {};
};

struct t_s3g_subxover {
    t_pxobject object;
    SubXoverImpl* impl = nullptr;
    void* infoOutlet = nullptr;
    long channels = kDefaultChannels;
    double sampleRate = 48000.0;
    bool prepared = false;
    double layout = static_cast<double>(static_cast<uint32_t>(s3g::LayoutPannerPreset::Quad));
    double mode = 0.0;
    double highchannels = 4.0;
    double subcount = 1.0;
    double suboffset = 5.0;
    double cutoff = 90.0;
    double subfocus = 1.5;
    double subgain = 0.0;
    double highgain = 0.0;
    double bypass = 0.0;
    double foldbypass = 1.0;
};

t_class* s_s3g_subxover_class = nullptr;

std::string lower_name(t_symbol* sym)
{
    std::string s = sym ? sym->s_name : "";
    for (auto& c : s) c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
    return s;
}

double atom_double_at(long argc, t_atom* argv, long index, double fallback)
{
    return (argv && index < argc) ? atom_getfloat(argv + index) : fallback;
}

long atom_long_at(long argc, t_atom* argv, long index, long fallback)
{
    return (argv && index < argc) ? atom_getlong(argv + index) : fallback;
}

s3g::LayoutPannerPreset preset_from_name(t_symbol* sym, s3g::LayoutPannerPreset fallback)
{
    const auto s = lower_name(sym);
    if (s == "custom") return s3g::LayoutPannerPreset::Custom;
    if (s == "cube8" || s == "cube") return s3g::LayoutPannerPreset::Cube8;
    if (s == "cube17") return s3g::LayoutPannerPreset::Cube17;
    if (s == "cube41") return s3g::LayoutPannerPreset::Cube41;
    if (s == "lpac41") return s3g::LayoutPannerPreset::Lpac41;
    if (s == "dodeca12" || s == "dodeca") return s3g::LayoutPannerPreset::Dodeca12;
    if (s == "dome24" || s == "dome") return s3g::LayoutPannerPreset::Dome24NoOverhead;
    if (s == "dome25") return s3g::LayoutPannerPreset::Dome25;
    if (s == "srst25") return s3g::LayoutPannerPreset::Srst25;
    if (s == "double16" || s == "dblring16") return s3g::LayoutPannerPreset::DoubleRing16;
    if (s == "double20" || s == "dblring20") return s3g::LayoutPannerPreset::DoubleRing20;
    if (s == "icosahedron20" || s == "icosa20" || s == "ico20") return s3g::LayoutPannerPreset::Icosahedron20;
    if (s == "octo" || s == "octo8" || s == "octophonic") return s3g::LayoutPannerPreset::OctophonicRing;
    if (s == "quad") return s3g::LayoutPannerPreset::Quad;
    if (s == "quad+oh" || s == "quadoh" || s == "quad-oh") return s3g::LayoutPannerPreset::QuadOverhead6;
    if (s == "ring12") return s3g::LayoutPannerPreset::Ring12;
    if (s == "ring16" || s == "ring") return s3g::LayoutPannerPreset::Ring16;
    if (s == "5.0" || s == "fivezero") return s3g::LayoutPannerPreset::FiveZero;
    if (s == "6.0" || s == "sixzero") return s3g::LayoutPannerPreset::SixZero;
    if (s == "7.0" || s == "sevenzero") return s3g::LayoutPannerPreset::SevenZero;
    if (s == "5.0.2" || s == "fivezerotwo") return s3g::LayoutPannerPreset::FiveZeroTwo;
    if (s == "7.0.2" || s == "sevenzerotwo") return s3g::LayoutPannerPreset::SevenZeroTwo;
    if (s == "5.0.4" || s == "fivezerofour") return s3g::LayoutPannerPreset::FiveZeroFour;
    if (s == "7.0.4" || s == "7.0.4." || s == "sevenzerofour") return s3g::LayoutPannerPreset::SevenZeroFour;
    if (s == "9.0" || s == "ninezero") return s3g::LayoutPannerPreset::NineZero;
    if (s == "9.0.2" || s == "ninezerotwo") return s3g::LayoutPannerPreset::NineZeroTwo;
    if (s == "9.0.4" || s == "ninezerofour") return s3g::LayoutPannerPreset::NineZeroFour;
    if (s == "9.0.6" || s == "ninezerosix") return s3g::LayoutPannerPreset::NineZeroSix;
    if (s == "7.0.6" || s == "sevenzerosix") return s3g::LayoutPannerPreset::SevenZeroSix;
    if (s == "11.0.8" || s == "elevenzeroeight") return s3g::LayoutPannerPreset::ElevenZeroEight;
    return fallback;
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
    default: return "quad";
    }
}

void sync_attrs(t_s3g_subxover* x)
{
    if (!x || !x->impl) return;
    x->layout = static_cast<double>(static_cast<uint32_t>(x->impl->params.layout));
    x->mode = static_cast<double>(static_cast<uint32_t>(x->impl->params.mode));
    x->highchannels = static_cast<double>(x->impl->params.highChannels);
    x->subcount = static_cast<double>(x->impl->params.subCount);
    x->suboffset = static_cast<double>(x->impl->params.subOffset);
    x->cutoff = x->impl->params.cutoffHz;
    x->subfocus = x->impl->params.subFocus;
    x->subgain = x->impl->params.subGainDb;
    x->highgain = x->impl->params.highGainDb;
    x->bypass = x->impl->params.bypass ? 1.0 : 0.0;
    x->foldbypass = x->impl->params.foldSubsOnBypass ? 1.0 : 0.0;
}

void s3g_subxover_dump(t_s3g_subxover* x);

void notify_attr(t_s3g_subxover* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void apply(t_s3g_subxover* x)
{
    if (!x || !x->impl) return;
    x->impl->xover.setParams(x->impl->params);
    x->impl->params = x->impl->xover.params();
    sync_attrs(x);
    s3g_subxover_dump(x);
}

void prepare(t_s3g_subxover* x, double sampleRate)
{
    if (!x || !x->impl) return;
    x->sampleRate = std::max(1.0, sampleRate);
    x->impl->xover.prepare(x->sampleRate);
    apply(x);
    x->prepared = true;
}

void set_layout(t_s3g_subxover* x, s3g::LayoutPannerPreset v)
{
    if (!x || !x->impl) return;
    const double oldLayout = x ? x->layout : 0.0;
    const double oldHighChannels = x ? x->highchannels : 0.0;
    const double oldSubOffset = x ? x->suboffset : 0.0;
    x->impl->params.layout = v;
    x->impl->params.highChannels = std::clamp<uint32_t>(
        s3g::layoutPannerPresetSpeakerCount(v, x->impl->params.highChannels),
        1u,
        static_cast<uint32_t>(kMaxChannels));
    x->impl->params.subOffset = std::min<uint32_t>(static_cast<uint32_t>(kMaxChannels), x->impl->params.highChannels + 1u);
    apply(x);
    if (x->layout != oldLayout) notify_attr(x, "layout");
    if (x->highchannels != oldHighChannels) notify_attr(x, "highchannels");
    if (x->suboffset != oldSubOffset) notify_attr(x, "suboffset");
}
void set_mode(t_s3g_subxover* x, s3g::SubCrossoverMode v) { x->impl->params.mode = v; apply(x); notify_attr(x, "mode"); }
void set_highchannels(t_s3g_subxover* x, double v) { x->impl->params.highChannels = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(kMaxChannels))); apply(x); notify_attr(x, "highchannels"); }
void set_subcount(t_s3g_subxover* x, double v) { x->impl->params.subCount = static_cast<uint32_t>(std::clamp(v, 1.0, 8.0)); apply(x); notify_attr(x, "subcount"); }
void set_suboffset(t_s3g_subxover* x, double v) { x->impl->params.subOffset = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(kMaxChannels))); apply(x); notify_attr(x, "suboffset"); }
void set_cutoff(t_s3g_subxover* x, double v) { x->impl->params.cutoffHz = static_cast<float>(v); apply(x); notify_attr(x, "cutoff"); }
void set_subfocus(t_s3g_subxover* x, double v) { x->impl->params.subFocus = static_cast<float>(v); apply(x); notify_attr(x, "subfocus"); }
void set_subgain(t_s3g_subxover* x, double v) { x->impl->params.subGainDb = static_cast<float>(v); apply(x); notify_attr(x, "subgain"); }
void set_highgain(t_s3g_subxover* x, double v) { x->impl->params.highGainDb = static_cast<float>(v); apply(x); notify_attr(x, "highgain"); }
void set_bypass(t_s3g_subxover* x, double v) { x->impl->params.bypass = v != 0.0; apply(x); notify_attr(x, "bypass"); }
void set_foldbypass(t_s3g_subxover* x, double v) { x->impl->params.foldSubsOnBypass = v != 0.0; apply(x); notify_attr(x, "foldbypass"); }

void s3g_subxover_layout(t_s3g_subxover* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return;
    if (atom_gettype(argv) == A_SYM) set_layout(x, preset_from_name(atom_getsym(argv), x->impl->params.layout));
    else set_layout(x, static_cast<s3g::LayoutPannerPreset>(std::clamp(atom_getlong(argv), 0L, 29L)));
}

void s3g_subxover_mode(t_s3g_subxover* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return;
    if (atom_gettype(argv) == A_SYM) {
        const auto s = lower_name(atom_getsym(argv));
        set_mode(x, s == "send" ? s3g::SubCrossoverMode::Send : s3g::SubCrossoverMode::Split);
    } else {
        set_mode(x, atom_getlong(argv) != 0 ? s3g::SubCrossoverMode::Send : s3g::SubCrossoverMode::Split);
    }
}

void s3g_subxover_highchannels(t_s3g_subxover* x, double v) { set_highchannels(x, v); }
void s3g_subxover_subcount(t_s3g_subxover* x, double v) { set_subcount(x, v); }
void s3g_subxover_suboffset(t_s3g_subxover* x, double v) { set_suboffset(x, v); }
void s3g_subxover_cutoff(t_s3g_subxover* x, double v) { set_cutoff(x, v); }
void s3g_subxover_subfocus(t_s3g_subxover* x, double v) { set_subfocus(x, v); }
void s3g_subxover_subgain(t_s3g_subxover* x, double v) { set_subgain(x, v); }
void s3g_subxover_highgain(t_s3g_subxover* x, double v) { set_highgain(x, v); }
void s3g_subxover_bypass(t_s3g_subxover* x, double v) { set_bypass(x, v); }
void s3g_subxover_foldbypass(t_s3g_subxover* x, double v) { set_foldbypass(x, v); }

t_max_err attr_layout_set(t_s3g_subxover* x, void*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return MAX_ERR_NONE;
    if (atom_gettype(argv) == A_SYM) set_layout(x, preset_from_name(atom_getsym(argv), x->impl ? x->impl->params.layout : s3g::LayoutPannerPreset::Quad));
    else set_layout(x, static_cast<s3g::LayoutPannerPreset>(std::clamp(atom_long_at(argc, argv, 0, static_cast<long>(x->layout)), 0L, 29L)));
    return MAX_ERR_NONE;
}
t_max_err attr_mode_set(t_s3g_subxover* x, void*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return MAX_ERR_NONE;
    if (atom_gettype(argv) == A_SYM) {
        const auto s = lower_name(atom_getsym(argv));
        set_mode(x, s == "send" ? s3g::SubCrossoverMode::Send : s3g::SubCrossoverMode::Split);
    } else {
        set_mode(x, atom_long_at(argc, argv, 0, static_cast<long>(x->mode)) != 0 ? s3g::SubCrossoverMode::Send : s3g::SubCrossoverMode::Split);
    }
    return MAX_ERR_NONE;
}
t_max_err attr_highchannels_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_highchannels(x, atom_double_at(argc, argv, 0, x->highchannels)); return MAX_ERR_NONE; }
t_max_err attr_subcount_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_subcount(x, atom_double_at(argc, argv, 0, x->subcount)); return MAX_ERR_NONE; }
t_max_err attr_suboffset_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_suboffset(x, atom_double_at(argc, argv, 0, x->suboffset)); return MAX_ERR_NONE; }
t_max_err attr_cutoff_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_cutoff(x, atom_double_at(argc, argv, 0, x->cutoff)); return MAX_ERR_NONE; }
t_max_err attr_subfocus_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_subfocus(x, atom_double_at(argc, argv, 0, x->subfocus)); return MAX_ERR_NONE; }
t_max_err attr_subgain_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_subgain(x, atom_double_at(argc, argv, 0, x->subgain)); return MAX_ERR_NONE; }
t_max_err attr_highgain_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_highgain(x, atom_double_at(argc, argv, 0, x->highgain)); return MAX_ERR_NONE; }
t_max_err attr_bypass_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_bypass(x, atom_double_at(argc, argv, 0, x->bypass)); return MAX_ERR_NONE; }
t_max_err attr_foldbypass_set(t_s3g_subxover* x, void*, long argc, t_atom* argv) { set_foldbypass(x, atom_double_at(argc, argv, 0, x->foldbypass)); return MAX_ERR_NONE; }

void s3g_subxover_dump(t_s3g_subxover* x)
{
    if (x && x->infoOutlet) {
        sync_attrs(x);
        t_atom atoms[11];
        atom_setlong(atoms, static_cast<long>(static_cast<uint32_t>(x->impl->params.layout)));
        atom_setsym(atoms + 1, gensym(preset_symbol_name(x->impl->params.layout)));
        outlet_anything(x->infoOutlet, gensym("layout"), 2, atoms);

        atom_setlong(atoms, x->impl->params.mode == s3g::SubCrossoverMode::Send ? 1 : 0);
        atom_setsym(atoms + 1, gensym(x->impl->params.mode == s3g::SubCrossoverMode::Send ? "send" : "split"));
        outlet_anything(x->infoOutlet, gensym("mode"), 2, atoms);

        atom_setlong(atoms, static_cast<long>(x->channels));
        atom_setlong(atoms + 1, static_cast<long>(x->impl->params.highChannels));
        atom_setlong(atoms + 2, static_cast<long>(x->impl->params.subCount));
        atom_setlong(atoms + 3, static_cast<long>(x->impl->params.subOffset));
        atom_setfloat(atoms + 4, x->impl->params.cutoffHz);
        atom_setfloat(atoms + 5, x->impl->params.subFocus);
        atom_setfloat(atoms + 6, x->impl->params.subGainDb);
        atom_setfloat(atoms + 7, x->impl->params.highGainDb);
        atom_setlong(atoms + 8, x->impl->params.bypass ? 1 : 0);
        atom_setlong(atoms + 9, x->impl->params.foldSubsOnBypass ? 1 : 0);
        outlet_anything(x->infoOutlet, gensym("state"), 10, atoms);
        outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
    }
    object_post(reinterpret_cast<t_object*>(x), "layout %s mode %s high %u subs %u offset %u cutoff %.1f",
                preset_symbol_name(x->impl->params.layout),
                s3g::subCrossoverModeName(x->impl->params.mode),
                x->impl->params.highChannels,
                x->impl->params.subCount,
                x->impl->params.subOffset,
                x->impl->params.cutoffHz);
}

void s3g_subxover_dsp64(t_s3g_subxover* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x || !x->impl) return;
    if (!x->prepared || sampleRate != x->sampleRate) prepare(x, sampleRate);
    object_method(dsp64, gensym("dsp_add64"), x, reinterpret_cast<method>(+[](t_s3g_subxover* x, t_object*, double** ins, long numins, double** outs, long numouts, long sampleframes, long, void*) {
        const long n = std::min<long>({ x->channels, numins, numouts, kMaxChannels });
        for (long i = 0; i < sampleframes; ++i) {
            for (long ch = 0; ch < kMaxChannels; ++ch) x->impl->frameIn[static_cast<size_t>(ch)] = (ch < n && ins[ch]) ? static_cast<float>(ins[ch][i]) : 0.0f;
            x->impl->xover.processFrame(x->impl->frameIn.data(), x->impl->frameOut.data(), static_cast<uint32_t>(n));
            for (long ch = 0; ch < n; ++ch) if (outs[ch]) outs[ch][i] = x->impl->frameOut[static_cast<size_t>(ch)];
            for (long ch = n; ch < numouts; ++ch) if (outs[ch]) outs[ch][i] = 0.0;
        }
    }), 0, nullptr);
}

void s3g_subxover_assist(t_s3g_subxover* x, void*, long message, long index, char* text)
{
    if (message == ASSIST_INLET) {
        snprintf_zero(text, 256, "Signal input %ld / messages", index + 1);
    } else if (x && index < x->channels) {
        snprintf_zero(text, 256, "Signal output %ld", index + 1);
    } else {
        snprintf_zero(text, 256, "Info outlet");
    }
}

void* s3g_subxover_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_subxover*>(object_alloc(s_s3g_subxover_class));
    if (!x) return nullptr;
    x->impl = new (std::nothrow) SubXoverImpl();
    if (!x->impl) {
        object_free(reinterpret_cast<t_object*>(x));
        return nullptr;
    }
    x->channels = std::clamp(atom_long_at(argc, argv, 0, kDefaultChannels), 1L, kMaxChannels);
    x->impl->params = s3g::SubCrossoverParams {};
    if (argc > 1 && atom_gettype(argv + 1) == A_SYM) {
        x->impl->params.layout = preset_from_name(atom_getsym(argv + 1), x->impl->params.layout);
        x->impl->params.highChannels = std::clamp<uint32_t>(
            s3g::layoutPannerPresetSpeakerCount(x->impl->params.layout, x->impl->params.highChannels),
            1u,
            static_cast<uint32_t>(kMaxChannels));
        if (x->impl->params.subOffset <= x->impl->params.highChannels) {
            x->impl->params.subOffset = std::min<uint32_t>(static_cast<uint32_t>(kMaxChannels), x->impl->params.highChannels + 1u);
        }
    }
    x->impl->xover.setParams(x->impl->params);
    sync_attrs(x);
    x->infoOutlet = outlet_new(reinterpret_cast<t_object*>(x), nullptr);
    dsp_setup(reinterpret_cast<t_pxobject*>(x), x->channels);
    for (long i = 0; i < x->channels; ++i) outlet_new(reinterpret_cast<t_object*>(x), "signal");
    attr_args_process(x, argc, argv);
    prepare(x, sys_getsr());
    return x;
}

void s3g_subxover_free(t_s3g_subxover* x)
{
    dsp_free(reinterpret_cast<t_pxobject*>(x));
    delete x->impl;
    x->impl = nullptr;
}

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.subxover~",
                           reinterpret_cast<method>(s3g_subxover_new),
                           reinterpret_cast<method>(s3g_subxover_free),
                           sizeof(t_s3g_subxover),
                           nullptr,
                           A_GIMME,
                           0);

    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_layout), "layout", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_mode), "mode", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_highchannels), "highchannels", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_subcount), "subcount", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_suboffset), "suboffset", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_cutoff), "cutoff", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_subfocus), "subfocus", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_subgain), "subgain", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_highgain), "highgain", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_bypass), "bypass", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_foldbypass), "foldbypass", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(s3g_subxover_dump), "dump", 0);

    CLASS_ATTR_DOUBLE(c, "layout", 0, t_s3g_subxover, layout);
    CLASS_ATTR_ACCESSORS(c, "layout", nullptr, attr_layout_set);
    CLASS_ATTR_ENUMINDEX(c, "layout", 0, "custom cube8 cube17 dodeca12 dome24 dome25 double16 double20 octo quad quad+oh ring12 ring16 5.0 6.0 7.0 5.0.2 7.0.2 5.0.4 7.0.4 9.0 9.0.2 9.0.4 9.0.6 7.0.6 11.0.8 icosahedron20 cube41 lpac41 srst25");
    CLASS_ATTR_FILTER_CLIP(c, "layout", 0, 29);
    CLASS_ATTR_DOUBLE(c, "mode", 0, t_s3g_subxover, mode);
    CLASS_ATTR_ACCESSORS(c, "mode", nullptr, attr_mode_set);
    CLASS_ATTR_ENUMINDEX(c, "mode", 0, "split send");
    CLASS_ATTR_FILTER_CLIP(c, "mode", 0, 1);

    CLASS_ATTR_DOUBLE(c, "highchannels", 0, t_s3g_subxover, highchannels);
    CLASS_ATTR_ACCESSORS(c, "highchannels", nullptr, attr_highchannels_set);
    CLASS_ATTR_FILTER_CLIP(c, "highchannels", 1, 64);
    CLASS_ATTR_DOUBLE(c, "subcount", 0, t_s3g_subxover, subcount);
    CLASS_ATTR_ACCESSORS(c, "subcount", nullptr, attr_subcount_set);
    CLASS_ATTR_FILTER_CLIP(c, "subcount", 1, 8);
    CLASS_ATTR_DOUBLE(c, "suboffset", 0, t_s3g_subxover, suboffset);
    CLASS_ATTR_ACCESSORS(c, "suboffset", nullptr, attr_suboffset_set);
    CLASS_ATTR_FILTER_CLIP(c, "suboffset", 1, 64);
    CLASS_ATTR_DOUBLE(c, "cutoff", 0, t_s3g_subxover, cutoff);
    CLASS_ATTR_ACCESSORS(c, "cutoff", nullptr, attr_cutoff_set);
    CLASS_ATTR_FILTER_CLIP(c, "cutoff", 20, 240);
    CLASS_ATTR_DOUBLE(c, "subfocus", 0, t_s3g_subxover, subfocus);
    CLASS_ATTR_ACCESSORS(c, "subfocus", nullptr, attr_subfocus_set);
    CLASS_ATTR_FILTER_CLIP(c, "subfocus", 0.25, 8.0);
    CLASS_ATTR_DOUBLE(c, "subgain", 0, t_s3g_subxover, subgain);
    CLASS_ATTR_ACCESSORS(c, "subgain", nullptr, attr_subgain_set);
    CLASS_ATTR_FILTER_CLIP(c, "subgain", -60, 18);
    CLASS_ATTR_DOUBLE(c, "highgain", 0, t_s3g_subxover, highgain);
    CLASS_ATTR_ACCESSORS(c, "highgain", nullptr, attr_highgain_set);
    CLASS_ATTR_FILTER_CLIP(c, "highgain", -60, 18);
    CLASS_ATTR_DOUBLE(c, "bypass", 0, t_s3g_subxover, bypass);
    CLASS_ATTR_ACCESSORS(c, "bypass", nullptr, attr_bypass_set);
    CLASS_ATTR_FILTER_CLIP(c, "bypass", 0, 1);
    CLASS_ATTR_DOUBLE(c, "foldbypass", 0, t_s3g_subxover, foldbypass);
    CLASS_ATTR_ACCESSORS(c, "foldbypass", nullptr, attr_foldbypass_set);
    CLASS_ATTR_FILTER_CLIP(c, "foldbypass", 0, 1);

    CLASS_ATTR_DEFAULT(c, "layout", 0, "9"); CLASS_ATTR_SAVE(c, "layout", 0);
    CLASS_ATTR_DEFAULT(c, "mode", 0, "0"); CLASS_ATTR_SAVE(c, "mode", 0);
    CLASS_ATTR_DEFAULT(c, "highchannels", 0, "4"); CLASS_ATTR_SAVE(c, "highchannels", 0);
    CLASS_ATTR_DEFAULT(c, "subcount", 0, "1"); CLASS_ATTR_SAVE(c, "subcount", 0);
    CLASS_ATTR_DEFAULT(c, "suboffset", 0, "5"); CLASS_ATTR_SAVE(c, "suboffset", 0);
    CLASS_ATTR_DEFAULT(c, "cutoff", 0, "90."); CLASS_ATTR_SAVE(c, "cutoff", 0);
    CLASS_ATTR_DEFAULT(c, "subfocus", 0, "1.5"); CLASS_ATTR_SAVE(c, "subfocus", 0);
    CLASS_ATTR_DEFAULT(c, "subgain", 0, "0."); CLASS_ATTR_SAVE(c, "subgain", 0);
    CLASS_ATTR_DEFAULT(c, "highgain", 0, "0."); CLASS_ATTR_SAVE(c, "highgain", 0);
    CLASS_ATTR_DEFAULT(c, "bypass", 0, "0"); CLASS_ATTR_SAVE(c, "bypass", 0);
    CLASS_ATTR_DEFAULT(c, "foldbypass", 0, "1"); CLASS_ATTR_SAVE(c, "foldbypass", 0);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_s3g_subxover_class = c;
}
