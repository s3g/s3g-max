#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_ambisonic_sub_decoder.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstring>

namespace {

constexpr long kMaxInputs = s3g::kAmbiSubDecoderMaxInputChannels;
constexpr long kMaxOutputs = s3g::kAmbiSubDecoderMaxSubs;

struct t_s3g_ambisubdecoder {
    t_pxobject object;
    s3g::AmbiSubDecoder decoder;
    s3g::AmbiSubDecoderParams params;
    std::array<float, kMaxInputs> frameIn {};
    std::array<float, kMaxOutputs> frameOut {};
    void* infoOutlet = nullptr;
    double sampleRate = 48000.0;
    long inputCount = 16;
    long outputCount = 1;
    long mc = 0;
    bool prepared = false;
    double order = 3.0;
    double subcount = 1.0;
    double cutoff = 90.0;
    double width = 1.0;
    double output = 0.0;
    double bypass = 0.0;
};

t_class* s_class = nullptr;

void perform64(t_s3g_ambisubdecoder* x,
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
    order = std::clamp<long>(order, 0, static_cast<long>(s3g::kAmbiSpeakerDecoderMaxOrder));
    return (order + 1) * (order + 1);
}

long atom_long_at(long argc, t_atom* argv, long index, long fallback)
{
    return argv && index < argc ? atom_getlong(argv + index) : fallback;
}

double atom_double_at(long argc, t_atom* argv, long index, double fallback)
{
    return argv && index < argc ? atom_getfloat(argv + index) : fallback;
}

long attr_long_arg(long argc, t_atom* argv, const char* name, long fallback)
{
    if (!argv || !name) return fallback;
    for (long i = 0; i < argc - 1; ++i) {
        if (atom_gettype(argv + i) != A_SYM) continue;
        auto* sym = atom_getsym(argv + i);
        if (sym && sym->s_name && sym->s_name[0] == '@' && std::strcmp(sym->s_name + 1, name) == 0) {
            return atom_getlong(argv + i + 1);
        }
    }
    return fallback;
}

void notify_attr(t_s3g_ambisubdecoder* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void sync_attrs(t_s3g_ambisubdecoder* x)
{
    if (!x) return;
    x->params = x->decoder.params();
    x->order = x->params.order;
    x->subcount = x->params.subCount;
    x->cutoff = x->params.cutoffHz;
    x->width = x->params.directionWidth;
    x->output = x->params.outputGainDb;
    x->bypass = x->params.bypass ? 1.0 : 0.0;
}

void dump(t_s3g_ambisubdecoder* x)
{
    if (!x || !x->infoOutlet) return;
    sync_attrs(x);
    t_atom atoms[8];
    atom_setlong(atoms, x->inputCount);
    atom_setlong(atoms + 1, x->outputCount);
    atom_setlong(atoms + 2, static_cast<long>(x->params.order));
    atom_setlong(atoms + 3, static_cast<long>(x->params.subCount));
    outlet_anything(x->infoOutlet, gensym("config"), 4, atoms);
    atom_setfloat(atoms, x->params.cutoffHz);
    atom_setfloat(atoms + 1, x->params.directionWidth);
    atom_setfloat(atoms + 2, x->params.outputGainDb);
    atom_setlong(atoms + 3, x->params.bypass ? 1 : 0);
    outlet_anything(x->infoOutlet, gensym("params"), 4, atoms);
    for (uint32_t i = 0; i < x->params.subCount; ++i) {
        atom_setlong(atoms, static_cast<long>(i + 1u));
        atom_setfloat(atoms + 1, s3g::AmbiSubDecoder::subAzimuth(i, x->params.subCount));
        outlet_anything(x->infoOutlet, gensym("sub"), 2, atoms);
    }
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

void apply(t_s3g_ambisubdecoder* x)
{
    x->decoder.setParams(x->params);
    sync_attrs(x);
    dump(x);
}

void prepare(t_s3g_ambisubdecoder* x, double sampleRate)
{
    x->sampleRate = std::max(1.0, sampleRate);
    x->decoder.prepare(x->sampleRate);
    x->decoder.setParams(x->params);
    x->prepared = true;
    sync_attrs(x);
}

void set_order(t_s3g_ambisubdecoder* x, double v) { x->params.order = static_cast<uint32_t>(std::clamp(v, 0.0, 7.0)); apply(x); notify_attr(x, "order"); }
void set_subcount(t_s3g_ambisubdecoder* x, double v) { x->params.subCount = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(x->outputCount))); apply(x); notify_attr(x, "subcount"); }
void set_cutoff(t_s3g_ambisubdecoder* x, double v) { x->params.cutoffHz = static_cast<float>(v); apply(x); notify_attr(x, "cutoff"); }
void set_width(t_s3g_ambisubdecoder* x, double v) { x->params.directionWidth = static_cast<float>(v); apply(x); notify_attr(x, "width"); }
void set_output(t_s3g_ambisubdecoder* x, double v) { x->params.outputGainDb = static_cast<float>(v); apply(x); notify_attr(x, "output"); }
void set_bypass(t_s3g_ambisubdecoder* x, double v) { x->params.bypass = v != 0.0; apply(x); notify_attr(x, "bypass"); }

t_max_err attr_order(t_s3g_ambisubdecoder* x, void*, long argc, t_atom* argv) { set_order(x, atom_double_at(argc, argv, 0, x->order)); return MAX_ERR_NONE; }
t_max_err attr_subcount(t_s3g_ambisubdecoder* x, void*, long argc, t_atom* argv) { set_subcount(x, atom_double_at(argc, argv, 0, x->subcount)); return MAX_ERR_NONE; }
t_max_err attr_cutoff(t_s3g_ambisubdecoder* x, void*, long argc, t_atom* argv) { set_cutoff(x, atom_double_at(argc, argv, 0, x->cutoff)); return MAX_ERR_NONE; }
t_max_err attr_width(t_s3g_ambisubdecoder* x, void*, long argc, t_atom* argv) { set_width(x, atom_double_at(argc, argv, 0, x->width)); return MAX_ERR_NONE; }
t_max_err attr_output(t_s3g_ambisubdecoder* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_bypass(t_s3g_ambisubdecoder* x, void*, long argc, t_atom* argv) { set_bypass(x, atom_double_at(argc, argv, 0, x->bypass)); return MAX_ERR_NONE; }

void dsp64(t_s3g_ambisubdecoder* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x->prepared || sampleRate != x->sampleRate) prepare(x, sampleRate);
    object_method(dsp64, gensym("dsp_add64"), x, perform64, 0, nullptr);
}

void perform64(t_s3g_ambisubdecoder* x, t_object*, double** ins, long numins, double** outs, long numouts, long frames, long, void*)
{
    if (!x || !x->prepared) return;
    const long inCount = std::min<long>({ x->inputCount, numins, kMaxInputs });
    const long outCount = std::min<long>({ x->outputCount, numouts, kMaxOutputs });
    x->decoder.processBlock(ins,
                            outs,
                            static_cast<uint32_t>(inCount),
                            static_cast<uint32_t>(outCount),
                            static_cast<uint32_t>(frames));
    for (long ch = outCount; ch < numouts; ++ch) {
        if (outs[ch]) std::fill(outs[ch], outs[ch] + frames, 0.0);
    }
}

void assist(t_s3g_ambisubdecoder* x, void*, long msg, long index, char* text)
{
    if (msg == ASSIST_INLET) snprintf_zero(text, 256, x && x->mc ? "MC ambisonic input / messages" : "Ambisonic signal input %ld / messages", index + 1);
    else if (x && x->mc && index == 0) snprintf_zero(text, 256, "MC sub outputs");
    else if (index < (x ? x->outputCount : 0)) snprintf_zero(text, 256, "Sub output %ld", index + 1);
    else snprintf_zero(text, 256, "Info outlet");
}

long multichanneloutputs(t_s3g_ambisubdecoder* x, long index)
{
    return x && x->mc && index == 0 ? x->outputCount : 0;
}

long inputchanged(t_s3g_ambisubdecoder*, long, long) { return false; }

void* ambisubdecoder_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_ambisubdecoder*>(object_alloc(s_class));
    if (!x) return nullptr;
    const long order = std::clamp(atom_long_at(argc, argv, 0, 3), 0L, 7L);
    x->inputCount = ambi_channels_for_order(order);
    x->outputCount = std::clamp(atom_long_at(argc, argv, 1, 1), 1L, kMaxOutputs);
    x->mc = attr_long_arg(argc, argv, "mc", 0) != 0 ? 1 : 0;
    x->params.order = static_cast<uint32_t>(order);
    x->params.subCount = static_cast<uint32_t>(x->outputCount);
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
    return x;
}

void free_object(t_s3g_ambisubdecoder* x) { dsp_free(reinterpret_cast<t_pxobject*>(x)); }

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.ambisubdecoder~", reinterpret_cast<method>(ambisubdecoder_new), reinterpret_cast<method>(free_object), sizeof(t_s3g_ambisubdecoder), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_order), "order", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_subcount), "subcount", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_cutoff), "cutoff", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_width), "width", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_bypass), "bypass", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(dump), "dump", 0);
    CLASS_ATTR_DOUBLE(c, "order", 0, t_s3g_ambisubdecoder, order); CLASS_ATTR_ACCESSORS(c, "order", nullptr, attr_order); CLASS_ATTR_FILTER_CLIP(c, "order", 0, 7);
    CLASS_ATTR_DOUBLE(c, "subcount", 0, t_s3g_ambisubdecoder, subcount); CLASS_ATTR_ACCESSORS(c, "subcount", nullptr, attr_subcount); CLASS_ATTR_FILTER_CLIP(c, "subcount", 1, 8);
    CLASS_ATTR_DOUBLE(c, "cutoff", 0, t_s3g_ambisubdecoder, cutoff); CLASS_ATTR_ACCESSORS(c, "cutoff", nullptr, attr_cutoff); CLASS_ATTR_FILTER_CLIP(c, "cutoff", 20, 240);
    CLASS_ATTR_DOUBLE(c, "width", 0, t_s3g_ambisubdecoder, width); CLASS_ATTR_ACCESSORS(c, "width", nullptr, attr_width); CLASS_ATTR_FILTER_CLIP(c, "width", 0, 2);
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_ambisubdecoder, output); CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output); CLASS_ATTR_FILTER_CLIP(c, "output", -60, 18);
    CLASS_ATTR_DOUBLE(c, "bypass", 0, t_s3g_ambisubdecoder, bypass); CLASS_ATTR_ACCESSORS(c, "bypass", nullptr, attr_bypass); CLASS_ATTR_FILTER_CLIP(c, "bypass", 0, 1);
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_ambisubdecoder, mc);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_class = c;
}
