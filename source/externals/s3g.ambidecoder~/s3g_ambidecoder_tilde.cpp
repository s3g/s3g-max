#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_ambisonic_speaker_decoder.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cmath>
#include <cstring>
#include <new>
#include <string>

namespace {

constexpr long kMaxInputs = s3g::kAmbiSpeakerDecoderMaxChannels;
constexpr long kMaxOutputs = s3g::kAmbiSpeakerDecoderMaxSpeakers;
constexpr long kMaxLayoutIndex = static_cast<long>(s3g::AmbiSpeakerLayoutPreset::Srst25);

struct AmbiDecoderImpl {
    s3g::AmbiSpeakerDecoder decoder;
    s3g::AmbiSpeakerDecoderParams params;
    std::array<float, kMaxInputs> frameIn {};
    std::array<float, kMaxOutputs> frameOut {};
};

struct t_s3g_ambidecoder {
    t_pxobject object;
    AmbiDecoderImpl* impl = nullptr;
    void* infoOutlet = nullptr;
    double sampleRate = 48000.0;
    long inputCount = 16;
    long outputCount = 24;
    long mc = 0;
    bool prepared = false;
    double order = 3.0;
    double layout = 7.0;
    double mode = 1.0;
    double weighting = 1.0;
    double width = 1.0;
    double energy = 1.0;
    double output = -6.0;
    double selected = 1.0;
    double azimuth = 0.0;
    double elevation = 0.0;
    double distance = 1.0;
    double speakergain = 1.0;
};

t_class* s_class = nullptr;

void perform64(t_s3g_ambidecoder* x,
               t_object*,
               double** ins,
               long numins,
               double** outs,
               long numouts,
               long frames,
               long,
               void*);

long ambi_channels_for_order(long order)
{
    order = std::clamp<long>(order, 1, static_cast<long>(s3g::kAmbiSpeakerDecoderMaxOrder));
    return (order + 1) * (order + 1);
}

std::string lower_name(t_symbol* sym)
{
    std::string s = sym ? sym->s_name : "";
    for (auto& c : s) c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
    return s;
}

long atom_long_at(long argc, t_atom* argv, long index, long fallback)
{
    return argv && index < argc ? atom_getlong(argv + index) : fallback;
}

double atom_double_at(long argc, t_atom* argv, long index, double fallback)
{
    return argv && index < argc ? atom_getfloat(argv + index) : fallback;
}

t_symbol* atom_symbol_at(long argc, t_atom* argv, long index, t_symbol* fallback)
{
    return argv && index < argc ? atom_getsym(argv + index) : fallback;
}

long attr_long_arg(long argc, t_atom* argv, const char* name, long fallback)
{
    if (!argv || !name) return fallback;
    for (long i = 0; i < argc - 1; ++i) {
        if (atom_gettype(argv + i) != A_SYM) continue;
        auto* sym = atom_getsym(argv + i);
        if (sym && sym->s_name && sym->s_name[0] == '@' && std::strcmp(sym->s_name + 1, name) == 0) return atom_getlong(argv + i + 1);
    }
    return fallback;
}

const t_atom* attr_atom_arg(long argc, t_atom* argv, const char* name)
{
    if (!argv || !name) return nullptr;
    for (long i = 0; i < argc - 1; ++i) {
        if (atom_gettype(argv + i) != A_SYM) continue;
        auto* sym = atom_getsym(argv + i);
        if (sym && sym->s_name && sym->s_name[0] == '@' && std::strcmp(sym->s_name + 1, name) == 0) return argv + i + 1;
    }
    return nullptr;
}

s3g::AmbiSpeakerLayoutPreset layout_from_name(t_symbol* sym, s3g::AmbiSpeakerLayoutPreset fallback)
{
    const auto s = lower_name(sym);
    if (s == "custom") return s3g::AmbiSpeakerLayoutPreset::Custom;
    if (s == "quad") return s3g::AmbiSpeakerLayoutPreset::Quad;
    if (s == "cube8" || s == "cube") return s3g::AmbiSpeakerLayoutPreset::Cube8;
    if (s == "cube17") return s3g::AmbiSpeakerLayoutPreset::Cube17;
    if (s == "cube41") return s3g::AmbiSpeakerLayoutPreset::Cube41;
    if (s == "lpac41") return s3g::AmbiSpeakerLayoutPreset::Lpac41;
    if (s == "dome24" || s == "dome") return s3g::AmbiSpeakerLayoutPreset::Dome24;
    if (s == "dome25") return s3g::AmbiSpeakerLayoutPreset::Dome25;
    if (s == "srst25") return s3g::AmbiSpeakerLayoutPreset::Srst25;
    if (s == "quad+oh" || s == "quadoh" || s == "quad-oh") return s3g::AmbiSpeakerLayoutPreset::QuadOverhead6;
    if (s == "sphere24" || s == "3oafx24" || s == "3oafx") return s3g::AmbiSpeakerLayoutPreset::Sphere24;
    if (s == "dodeca12" || s == "dodeca") return s3g::AmbiSpeakerLayoutPreset::Dodeca12;
    if (s == "icosahedron20" || s == "icosa20" || s == "icosahedron" || s == "icosa") return s3g::AmbiSpeakerLayoutPreset::Icosahedron20;
    if (s == "octo" || s == "octoring" || s == "octo-ring" || s == "octophonicring") return s3g::AmbiSpeakerLayoutPreset::OctophonicRing;
    return fallback;
}

s3g::AmbiSpeakerDecoderMode mode_from_atom(const t_atom* atom, s3g::AmbiSpeakerDecoderMode fallback)
{
    if (!atom) return fallback;
    if (atom_gettype(atom) == A_SYM) {
        const auto s = lower_name(atom_getsym(atom));
        if (s == "basic") return s3g::AmbiSpeakerDecoderMode::Basic;
        if (s == "epad") return s3g::AmbiSpeakerDecoderMode::Epad;
        if (s == "mmd") return s3g::AmbiSpeakerDecoderMode::Mmd;
        return fallback;
    }
    return static_cast<s3g::AmbiSpeakerDecoderMode>(std::clamp<uint32_t>(static_cast<uint32_t>(std::lround(atom_getfloat(atom))), 0u, 2u));
}

s3g::AmbiSpeakerDecoderWeighting weighting_from_atom(const t_atom* atom, s3g::AmbiSpeakerDecoderWeighting fallback)
{
    if (!atom) return fallback;
    if (atom_gettype(atom) == A_SYM) {
        const auto s = lower_name(atom_getsym(atom));
        if (s == "none") return s3g::AmbiSpeakerDecoderWeighting::None;
        if (s == "maxre" || s == "max-re" || s == "max_re") return s3g::AmbiSpeakerDecoderWeighting::MaxRe;
        if (s == "inphase" || s == "in-phase" || s == "in_phase") return s3g::AmbiSpeakerDecoderWeighting::InPhase;
        return fallback;
    }
    return static_cast<s3g::AmbiSpeakerDecoderWeighting>(std::clamp<uint32_t>(static_cast<uint32_t>(std::lround(atom_getfloat(atom))), 0u, 2u));
}

const char* layout_name(s3g::AmbiSpeakerLayoutPreset layout)
{
    switch (layout) {
    case s3g::AmbiSpeakerLayoutPreset::Custom: return "custom";
    case s3g::AmbiSpeakerLayoutPreset::Quad: return "quad";
    case s3g::AmbiSpeakerLayoutPreset::Cube8: return "cube8";
    case s3g::AmbiSpeakerLayoutPreset::Cube17: return "cube17";
    case s3g::AmbiSpeakerLayoutPreset::Cube41: return "cube41";
    case s3g::AmbiSpeakerLayoutPreset::Lpac41: return "lpac41";
    case s3g::AmbiSpeakerLayoutPreset::Dome24: return "dome24";
    case s3g::AmbiSpeakerLayoutPreset::Dome25: return "dome25";
    case s3g::AmbiSpeakerLayoutPreset::Srst25: return "srst25";
    case s3g::AmbiSpeakerLayoutPreset::QuadOverhead6: return "quad+oh";
    case s3g::AmbiSpeakerLayoutPreset::Sphere24: return "sphere24";
    case s3g::AmbiSpeakerLayoutPreset::Dodeca12: return "dodeca12";
    case s3g::AmbiSpeakerLayoutPreset::Icosahedron20: return "icosahedron20";
    case s3g::AmbiSpeakerLayoutPreset::OctophonicRing: return "octo";
    default: return "sphere24";
    }
}

void dump(t_s3g_ambidecoder* x);

void initialize_defaults(t_s3g_ambidecoder* x)
{
    if (!x || !x->impl) return;
    x->infoOutlet = nullptr;
    x->sampleRate = 48000.0;
    x->inputCount = 16;
    x->outputCount = 24;
    x->mc = 0;
    x->prepared = false;
    x->order = 3.0;
    x->layout = static_cast<double>(static_cast<uint32_t>(s3g::AmbiSpeakerLayoutPreset::Sphere24));
    x->mode = static_cast<double>(static_cast<uint32_t>(s3g::AmbiSpeakerDecoderMode::Epad));
    x->weighting = static_cast<double>(static_cast<uint32_t>(s3g::AmbiSpeakerDecoderWeighting::MaxRe));
    x->width = 1.0;
    x->energy = 1.0;
    x->output = -6.0;
    x->selected = 1.0;
    x->azimuth = 0.0;
    x->elevation = 0.0;
    x->distance = 1.0;
    x->speakergain = 1.0;

    x->impl->params = {};
    x->impl->params.order = 3;
    x->impl->params.activeSpeakers = 24;
    x->impl->params.layout = s3g::AmbiSpeakerLayoutPreset::Sphere24;
    x->impl->params.mode = s3g::AmbiSpeakerDecoderMode::Epad;
    x->impl->params.weighting = s3g::AmbiSpeakerDecoderWeighting::MaxRe;
    x->impl->params.width = 1.0f;
    x->impl->params.energy = 1.0f;
    x->impl->params.outputGainDb = -6.0f;
}

void notify_attr(t_s3g_ambidecoder* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void notify_selected_speaker_attrs(t_s3g_ambidecoder* x)
{
    notify_attr(x, "azimuth");
    notify_attr(x, "elevation");
    notify_attr(x, "distance");
    notify_attr(x, "speakergain");
}

void sync_attrs(t_s3g_ambidecoder* x)
{
    if (!x || !x->impl) return;
    auto& impl = *x->impl;
    impl.params = impl.decoder.params();
    const auto sp = impl.decoder.speaker(impl.params.selectedSpeaker);
    x->order = impl.params.order;
    x->layout = static_cast<double>(static_cast<uint32_t>(impl.params.layout));
    x->mode = static_cast<double>(static_cast<uint32_t>(impl.params.mode));
    x->weighting = static_cast<double>(static_cast<uint32_t>(impl.params.weighting));
    x->width = impl.params.width;
    x->energy = impl.params.energy;
    x->output = impl.params.outputGainDb;
    x->selected = impl.params.selectedSpeaker + 1u;
    x->azimuth = sp.azimuthDeg;
    x->elevation = sp.elevationDeg;
    x->distance = sp.distance;
    x->speakergain = sp.gain;
}

void apply(t_s3g_ambidecoder* x)
{
    if (!x || !x->impl) return;
    x->impl->decoder.setParams(x->impl->params);
    sync_attrs(x);
    dump(x);
}

void prepare(t_s3g_ambidecoder* x, double sampleRate)
{
    if (!x || !x->impl) return;
    x->sampleRate = std::max(1.0, sampleRate);
    x->impl->decoder.prepare(x->sampleRate);
    x->impl->decoder.setParams(x->impl->params);
    x->prepared = true;
    sync_attrs(x);
}

void set_layout(t_s3g_ambidecoder* x, s3g::AmbiSpeakerLayoutPreset v) { if (!x || !x->impl) return; x->impl->params.layout = v; apply(x); notify_attr(x, "layout"); notify_selected_speaker_attrs(x); }
void set_mode(t_s3g_ambidecoder* x, s3g::AmbiSpeakerDecoderMode v) { if (!x || !x->impl) return; x->impl->params.mode = v; apply(x); notify_attr(x, "mode"); }
void set_weighting(t_s3g_ambidecoder* x, s3g::AmbiSpeakerDecoderWeighting v) { if (!x || !x->impl) return; x->impl->params.weighting = v; apply(x); notify_attr(x, "weighting"); }
void set_width(t_s3g_ambidecoder* x, double v) { if (!x || !x->impl) return; x->impl->params.width = static_cast<float>(v); apply(x); notify_attr(x, "width"); }
void set_energy(t_s3g_ambidecoder* x, double v) { if (!x || !x->impl) return; x->impl->params.energy = static_cast<float>(v); apply(x); notify_attr(x, "energy"); }
void set_output(t_s3g_ambidecoder* x, double v) { if (!x || !x->impl) return; x->impl->params.outputGainDb = static_cast<float>(v); apply(x); notify_attr(x, "output"); }
void set_selected(t_s3g_ambidecoder* x, double v) { if (!x || !x->impl) return; x->impl->params.selectedSpeaker = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(x->outputCount))) - 1u; apply(x); notify_attr(x, "selected"); notify_selected_speaker_attrs(x); }

void set_selected_speaker(t_s3g_ambidecoder* x, double az, double el, double dist, double gain)
{
    if (!x || !x->impl) return;
    auto sp = x->impl->decoder.speaker(x->impl->params.selectedSpeaker);
    sp.azimuthDeg = static_cast<float>(az);
    sp.elevationDeg = static_cast<float>(el);
    sp.distance = static_cast<float>(dist);
    sp.gain = static_cast<float>(gain);
    x->impl->decoder.setSpeaker(x->impl->params.selectedSpeaker, sp);
    sync_attrs(x);
    dump(x);
    notify_selected_speaker_attrs(x);
}

void msg_layout(t_s3g_ambidecoder* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return;
    if (atom_gettype(argv) == A_SYM) set_layout(x, layout_from_name(atom_getsym(argv), x->impl ? x->impl->params.layout : s3g::AmbiSpeakerLayoutPreset::Sphere24));
    else set_layout(x, static_cast<s3g::AmbiSpeakerLayoutPreset>(std::clamp(atom_getlong(argv), 0L, kMaxLayoutIndex)));
}

void msg_mode(t_s3g_ambidecoder* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return;
    set_mode(x, mode_from_atom(argv, x->impl->params.mode));
}

void msg_weighting(t_s3g_ambidecoder* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || !x->impl || argc < 1 || !argv) return;
    set_weighting(x, weighting_from_atom(argv, x->impl->params.weighting));
}

void msg_speaker(t_s3g_ambidecoder* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 4) return;
    const uint32_t index = static_cast<uint32_t>(std::clamp(atom_long_at(argc, argv, 0, 1), 1L, x->outputCount)) - 1u;
    s3g::AmbiSpeaker sp {};
    sp.azimuthDeg = static_cast<float>(atom_double_at(argc, argv, 1, 0.0));
    sp.elevationDeg = static_cast<float>(atom_double_at(argc, argv, 2, 0.0));
    sp.distance = static_cast<float>(atom_double_at(argc, argv, 3, 1.0));
    sp.gain = static_cast<float>(atom_double_at(argc, argv, 4, 1.0));
    sp.enabled = true;
    if (!x->impl) return;
    x->impl->decoder.setSpeaker(index, sp);
    x->impl->params = x->impl->decoder.params();
    sync_attrs(x);
    dump(x);
    if (index == x->impl->params.selectedSpeaker) notify_selected_speaker_attrs(x);
}

void dump(t_s3g_ambidecoder* x)
{
    if (!x || !x->infoOutlet) return;
    sync_attrs(x);
    t_atom atoms[8];
    atom_setlong(atoms, x->inputCount);
    atom_setlong(atoms + 1, x->outputCount);
    if (!x->impl) return;
    const auto& params = x->impl->params;
    atom_setlong(atoms + 2, static_cast<long>(params.order));
    atom_setlong(atoms + 3, static_cast<long>(params.activeSpeakers));
    outlet_anything(x->infoOutlet, gensym("config"), 4, atoms);
    atom_setlong(atoms, static_cast<long>(static_cast<uint32_t>(params.layout)));
    atom_setsym(atoms + 1, gensym(layout_name(params.layout)));
    outlet_anything(x->infoOutlet, gensym("layout"), 2, atoms);
    for (uint32_t i = 0; i < std::min<uint32_t>(params.activeSpeakers, x->outputCount); ++i) {
        const auto sp = x->impl->decoder.speaker(i);
        atom_setlong(atoms, static_cast<long>(i + 1u));
        atom_setfloat(atoms + 1, sp.azimuthDeg);
        atom_setfloat(atoms + 2, sp.elevationDeg);
        atom_setfloat(atoms + 3, sp.distance);
        atom_setfloat(atoms + 4, sp.gain);
        outlet_anything(x->infoOutlet, gensym("speaker"), 5, atoms);
    }
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

t_max_err attr_layout(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { if (argc > 0 && argv && atom_gettype(argv) == A_SYM) set_layout(x, layout_from_name(atom_getsym(argv), x && x->impl ? x->impl->params.layout : s3g::AmbiSpeakerLayoutPreset::Sphere24)); else set_layout(x, static_cast<s3g::AmbiSpeakerLayoutPreset>(std::clamp(atom_long_at(argc, argv, 0, static_cast<long>(x ? x->layout : 0.0)), 0L, kMaxLayoutIndex))); return MAX_ERR_NONE; }
t_max_err attr_mode(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_mode(x, mode_from_atom(argc > 0 ? argv : nullptr, x && x->impl ? x->impl->params.mode : s3g::AmbiSpeakerDecoderMode::Epad)); return MAX_ERR_NONE; }
t_max_err attr_weighting(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_weighting(x, weighting_from_atom(argc > 0 ? argv : nullptr, x && x->impl ? x->impl->params.weighting : s3g::AmbiSpeakerDecoderWeighting::MaxRe)); return MAX_ERR_NONE; }
t_max_err attr_width(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_width(x, atom_double_at(argc, argv, 0, x->width)); return MAX_ERR_NONE; }
t_max_err attr_energy(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_energy(x, atom_double_at(argc, argv, 0, x->energy)); return MAX_ERR_NONE; }
t_max_err attr_output(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_selected(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_selected(x, atom_double_at(argc, argv, 0, x->selected)); return MAX_ERR_NONE; }
t_max_err attr_azimuth(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_selected_speaker(x, atom_double_at(argc, argv, 0, x->azimuth), x->elevation, x->distance, x->speakergain); return MAX_ERR_NONE; }
t_max_err attr_elevation(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_selected_speaker(x, x->azimuth, atom_double_at(argc, argv, 0, x->elevation), x->distance, x->speakergain); return MAX_ERR_NONE; }
t_max_err attr_distance(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_selected_speaker(x, x->azimuth, x->elevation, atom_double_at(argc, argv, 0, x->distance), x->speakergain); return MAX_ERR_NONE; }
t_max_err attr_speakergain(t_s3g_ambidecoder* x, void*, long argc, t_atom* argv) { set_selected_speaker(x, x->azimuth, x->elevation, x->distance, atom_double_at(argc, argv, 0, x->speakergain)); return MAX_ERR_NONE; }

void dsp64(t_s3g_ambidecoder* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x->prepared || sampleRate != x->sampleRate) prepare(x, sampleRate);
    object_method(dsp64, gensym("dsp_add64"), x, perform64, 0, nullptr);
}

void perform64(t_s3g_ambidecoder* x, t_object*, double** ins, long numins, double** outs, long numouts, long frames, long, void*)
{
    if (!x || !x->prepared) return;
    const long inCount = std::min<long>({ x->inputCount, numins, kMaxInputs });
    const long outCount = std::min<long>({ x->outputCount, numouts, kMaxOutputs });
    if (!x->impl) return;
    x->impl->decoder.processBlock(ins,
                            outs,
                            static_cast<uint32_t>(inCount),
                            static_cast<uint32_t>(outCount),
                            static_cast<uint32_t>(frames));
    for (long ch = outCount; ch < numouts; ++ch) {
        if (outs[ch]) std::fill(outs[ch], outs[ch] + frames, 0.0);
    }
}

void assist(t_s3g_ambidecoder* x, void*, long msg, long index, char* text)
{
    if (msg == ASSIST_INLET) snprintf_zero(text, 256, x && x->mc ? "MC ambisonic input / messages" : "Ambisonic signal input %ld / messages", index + 1);
    else if (x && x->mc && index == 0) snprintf_zero(text, 256, "MC speaker outputs");
    else if (index < (x ? x->outputCount : 0)) snprintf_zero(text, 256, "Speaker output %ld", index + 1);
    else snprintf_zero(text, 256, "Info outlet");
}

long multichanneloutputs(t_s3g_ambidecoder* x, long index) { return x && x->mc && index == 0 ? x->outputCount : 0; }
long inputchanged(t_s3g_ambidecoder*, long, long) { return false; }

void* ambidecoder_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_ambidecoder*>(object_alloc(s_class));
    if (!x) return nullptr;
    x->impl = new (std::nothrow) AmbiDecoderImpl();
    if (!x->impl) {
        object_free(reinterpret_cast<t_object*>(x));
        return nullptr;
    }
    initialize_defaults(x);
    const long order = std::clamp(atom_long_at(argc, argv, 0, 3), 1L, 7L);
    x->inputCount = ambi_channels_for_order(order);
    x->outputCount = std::clamp(atom_long_at(argc, argv, 1, 24), 2L, kMaxOutputs);
    x->mc = attr_long_arg(argc, argv, "mc", 0) != 0 ? 1 : 0;
    x->impl->params.order = static_cast<uint32_t>(order);
    x->impl->params.activeSpeakers = static_cast<uint32_t>(x->outputCount);
    x->impl->params.layout = layout_from_name(atom_symbol_at(argc, argv, 2, gensym("sphere24")), s3g::AmbiSpeakerLayoutPreset::Sphere24);
    x->impl->decoder.setParams(x->impl->params);
    sync_attrs(x);
    x->infoOutlet = outlet_new(reinterpret_cast<t_object*>(x), nullptr);
    if (x->mc) {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), 1);
        x->object.z_misc |= Z_NO_INPLACE | Z_MC_INLETS;
        outlet_new(reinterpret_cast<t_object*>(x), "multichannelsignal");
    } else {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), x->inputCount);
        for (long i = 0; i < x->outputCount; ++i) outlet_new(reinterpret_cast<t_object*>(x), "signal");
    }
    attr_args_process(x, argc, argv);
    prepare(x, sys_getsr());
    notify_attr(x, "layout");
    notify_attr(x, "mode");
    notify_attr(x, "weighting");
    notify_attr(x, "width");
    notify_attr(x, "energy");
    notify_attr(x, "output");
    notify_attr(x, "selected");
    notify_selected_speaker_attrs(x);
    return x;
}

void free_object(t_s3g_ambidecoder* x)
{
    dsp_free(reinterpret_cast<t_pxobject*>(x));
    delete x->impl;
    x->impl = nullptr;
}

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.ambidecoder~", reinterpret_cast<method>(ambidecoder_new), reinterpret_cast<method>(free_object), sizeof(t_s3g_ambidecoder), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_layout), "layout", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_speaker), "speaker", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_mode), "mode", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_weighting), "weighting", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(set_width), "width", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_energy), "energy", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_selected), "select", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(dump), "dump", 0);
    CLASS_ATTR_DOUBLE(c, "layout", 0, t_s3g_ambidecoder, layout); CLASS_ATTR_ACCESSORS(c, "layout", nullptr, attr_layout); CLASS_ATTR_ENUMINDEX(c, "layout", 0, "custom quad cube8 cube17 dome24 dome25 quad+oh sphere24 dodeca12 icosahedron20 octo cube41 lpac41 srst25"); CLASS_ATTR_FILTER_CLIP(c, "layout", 0, kMaxLayoutIndex); CLASS_ATTR_DEFAULT(c, "layout", 0, "7"); CLASS_ATTR_SAVE(c, "layout", 0);
    CLASS_ATTR_DOUBLE(c, "mode", 0, t_s3g_ambidecoder, mode); CLASS_ATTR_ACCESSORS(c, "mode", nullptr, attr_mode); CLASS_ATTR_ENUMINDEX(c, "mode", 0, "basic epad mmd"); CLASS_ATTR_FILTER_CLIP(c, "mode", 0, 2); CLASS_ATTR_DEFAULT(c, "mode", 0, "1"); CLASS_ATTR_SAVE(c, "mode", 0);
    CLASS_ATTR_DOUBLE(c, "weighting", 0, t_s3g_ambidecoder, weighting); CLASS_ATTR_ACCESSORS(c, "weighting", nullptr, attr_weighting); CLASS_ATTR_ENUMINDEX(c, "weighting", 0, "none maxre inphase"); CLASS_ATTR_FILTER_CLIP(c, "weighting", 0, 2); CLASS_ATTR_DEFAULT(c, "weighting", 0, "1"); CLASS_ATTR_SAVE(c, "weighting", 0);
    CLASS_ATTR_DOUBLE(c, "width", 0, t_s3g_ambidecoder, width); CLASS_ATTR_ACCESSORS(c, "width", nullptr, attr_width); CLASS_ATTR_FILTER_CLIP(c, "width", 0, 1.5); CLASS_ATTR_DEFAULT(c, "width", 0, "1."); CLASS_ATTR_SAVE(c, "width", 0);
    CLASS_ATTR_DOUBLE(c, "energy", 0, t_s3g_ambidecoder, energy); CLASS_ATTR_ACCESSORS(c, "energy", nullptr, attr_energy); CLASS_ATTR_FILTER_CLIP(c, "energy", 0, 1.5); CLASS_ATTR_DEFAULT(c, "energy", 0, "1."); CLASS_ATTR_SAVE(c, "energy", 0);
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_ambidecoder, output); CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output); CLASS_ATTR_FILTER_CLIP(c, "output", -60, 12); CLASS_ATTR_DEFAULT(c, "output", 0, "-6."); CLASS_ATTR_SAVE(c, "output", 0);
    CLASS_ATTR_DOUBLE(c, "selected", 0, t_s3g_ambidecoder, selected); CLASS_ATTR_ACCESSORS(c, "selected", nullptr, attr_selected); CLASS_ATTR_FILTER_CLIP(c, "selected", 1, 64); CLASS_ATTR_DEFAULT(c, "selected", 0, "1"); CLASS_ATTR_SAVE(c, "selected", 0);
    CLASS_ATTR_DOUBLE(c, "azimuth", 0, t_s3g_ambidecoder, azimuth); CLASS_ATTR_ACCESSORS(c, "azimuth", nullptr, attr_azimuth); CLASS_ATTR_FILTER_CLIP(c, "azimuth", -180, 180); CLASS_ATTR_DEFAULT(c, "azimuth", 0, "0."); CLASS_ATTR_SAVE(c, "azimuth", 0);
    CLASS_ATTR_DOUBLE(c, "elevation", 0, t_s3g_ambidecoder, elevation); CLASS_ATTR_ACCESSORS(c, "elevation", nullptr, attr_elevation); CLASS_ATTR_FILTER_CLIP(c, "elevation", -90, 90); CLASS_ATTR_DEFAULT(c, "elevation", 0, "0."); CLASS_ATTR_SAVE(c, "elevation", 0);
    CLASS_ATTR_DOUBLE(c, "distance", 0, t_s3g_ambidecoder, distance); CLASS_ATTR_ACCESSORS(c, "distance", nullptr, attr_distance); CLASS_ATTR_FILTER_CLIP(c, "distance", 0.15, 2); CLASS_ATTR_DEFAULT(c, "distance", 0, "1."); CLASS_ATTR_SAVE(c, "distance", 0);
    CLASS_ATTR_DOUBLE(c, "speakergain", 0, t_s3g_ambidecoder, speakergain); CLASS_ATTR_ACCESSORS(c, "speakergain", nullptr, attr_speakergain); CLASS_ATTR_FILTER_CLIP(c, "speakergain", 0, 2); CLASS_ATTR_DEFAULT(c, "speakergain", 0, "1."); CLASS_ATTR_SAVE(c, "speakergain", 0);
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_ambidecoder, mc);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_class = c;
}
