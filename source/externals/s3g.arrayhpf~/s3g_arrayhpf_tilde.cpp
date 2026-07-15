#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_array_hpf.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstring>

namespace {

constexpr long kDefaultChannels = 16;
constexpr long kMaxChannels = s3g::kArrayHpfMaxChannels;

struct t_s3g_arrayhpf {
    t_pxobject object;
    s3g::ArrayHpf hpf;
    s3g::ArrayHpfParams params;
    void* infoOutlet = nullptr;
    long channels = kDefaultChannels;
    long mc = 0;
    double sampleRate = 48000.0;
    bool prepared = false;
    double activechannels = kDefaultChannels;
    double cutoff = 90.0;
    double poles = 2.0;
    double output = 0.0;
    double bypass = 0.0;
};

t_class* s_class = nullptr;

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
        const auto* sym = atom_getsym(argv + i);
        if (sym && sym->s_name && sym->s_name[0] == '@' && std::strcmp(sym->s_name + 1, name) == 0) return atom_getlong(argv + i + 1);
    }
    return fallback;
}

void notify_attr(t_s3g_arrayhpf* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void sync_attrs(t_s3g_arrayhpf* x)
{
    if (!x) return;
    x->params = x->hpf.params();
    x->activechannels = x->params.activeChannels;
    x->cutoff = x->params.cutoffHz;
    x->poles = x->params.poles;
    x->output = x->params.outputGainDb;
    x->bypass = x->params.bypass ? 1.0 : 0.0;
}

void dump(t_s3g_arrayhpf* x)
{
    if (!x || !x->infoOutlet) return;
    sync_attrs(x);
    t_atom atoms[8];
    atom_setlong(atoms, x->channels);
    atom_setlong(atoms + 1, static_cast<long>(x->params.activeChannels));
    atom_setlong(atoms + 2, static_cast<long>(x->params.poles));
    outlet_anything(x->infoOutlet, gensym("config"), 3, atoms);
    atom_setfloat(atoms, x->params.cutoffHz);
    atom_setfloat(atoms + 1, x->params.outputGainDb);
    atom_setlong(atoms + 2, x->params.bypass ? 1 : 0);
    outlet_anything(x->infoOutlet, gensym("state"), 3, atoms);
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

void apply(t_s3g_arrayhpf* x)
{
    if (!x) return;
    x->hpf.setParams(x->params);
    sync_attrs(x);
    dump(x);
}

void prepare(t_s3g_arrayhpf* x, double sampleRate)
{
    if (!x) return;
    x->sampleRate = std::max(1.0, sampleRate);
    x->hpf.prepare(x->sampleRate);
    x->hpf.setParams(x->params);
    x->prepared = true;
    sync_attrs(x);
}

void set_activechannels(t_s3g_arrayhpf* x, double v) { x->params.activeChannels = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(x->channels))); apply(x); notify_attr(x, "activechannels"); }
void set_cutoff(t_s3g_arrayhpf* x, double v) { x->params.cutoffHz = static_cast<float>(v); apply(x); notify_attr(x, "cutoff"); }
void set_poles(t_s3g_arrayhpf* x, double v) { x->params.poles = static_cast<uint32_t>(std::clamp(std::floor(v + 0.5), 1.0, 4.0)); apply(x); notify_attr(x, "poles"); }
void set_output(t_s3g_arrayhpf* x, double v) { x->params.outputGainDb = static_cast<float>(v); apply(x); notify_attr(x, "output"); }
void set_bypass(t_s3g_arrayhpf* x, double v) { x->params.bypass = v != 0.0; apply(x); notify_attr(x, "bypass"); }

t_max_err attr_activechannels(t_s3g_arrayhpf* x, void*, long argc, t_atom* argv) { set_activechannels(x, atom_double_at(argc, argv, 0, x->activechannels)); return MAX_ERR_NONE; }
t_max_err attr_cutoff(t_s3g_arrayhpf* x, void*, long argc, t_atom* argv) { set_cutoff(x, atom_double_at(argc, argv, 0, x->cutoff)); return MAX_ERR_NONE; }
t_max_err attr_poles(t_s3g_arrayhpf* x, void*, long argc, t_atom* argv) { set_poles(x, atom_double_at(argc, argv, 0, x->poles)); return MAX_ERR_NONE; }
t_max_err attr_output(t_s3g_arrayhpf* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_bypass(t_s3g_arrayhpf* x, void*, long argc, t_atom* argv) { set_bypass(x, atom_double_at(argc, argv, 0, x->bypass)); return MAX_ERR_NONE; }

void perform64(t_s3g_arrayhpf* x, t_object*, double** ins, long numins, double** outs, long numouts, long frames, long, void*)
{
    if (!x || !x->prepared) return;
    const long inCount = std::min<long>({ x->channels, numins, kMaxChannels });
    const long outCount = std::min<long>({ x->channels, numouts, kMaxChannels });
    x->hpf.processBlock(ins, outs, static_cast<uint32_t>(inCount), static_cast<uint32_t>(outCount), static_cast<uint32_t>(frames));
    for (long ch = outCount; ch < numouts; ++ch) {
        if (outs[ch]) std::fill(outs[ch], outs[ch] + frames, 0.0);
    }
}

void dsp64(t_s3g_arrayhpf* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x->prepared || sampleRate != x->sampleRate) prepare(x, sampleRate);
    object_method(dsp64, gensym("dsp_add64"), x, perform64, 0, nullptr);
}

void assist(t_s3g_arrayhpf* x, void*, long msg, long index, char* text)
{
    if (msg == ASSIST_INLET) snprintf_zero(text, 256, x && x->mc ? "MC main array input / messages" : "Main array signal input %ld / messages", index + 1);
    else if (x && x->mc && index == 0) snprintf_zero(text, 256, "MC highpassed main array output");
    else if (index < (x ? x->channels : 0)) snprintf_zero(text, 256, "Highpassed main array output %ld", index + 1);
    else snprintf_zero(text, 256, "Info outlet");
}

long multichanneloutputs(t_s3g_arrayhpf* x, long index)
{
    return x && x->mc && index == 0 ? x->channels : 0;
}

long inputchanged(t_s3g_arrayhpf*, long, long) { return false; }

void* arrayhpf_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_arrayhpf*>(object_alloc(s_class));
    if (!x) return nullptr;
    x->channels = std::clamp(atom_long_at(argc, argv, 0, kDefaultChannels), 1L, kMaxChannels);
    x->mc = attr_long_arg(argc, argv, "mc", 0) != 0 ? 1 : 0;
    x->params.activeChannels = static_cast<uint32_t>(x->channels);
    x->infoOutlet = outlet_new(reinterpret_cast<t_object*>(x), nullptr);
    if (x->mc) {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), 1);
        x->object.z_misc |= Z_NO_INPLACE | Z_MC_INLETS;
        outlet_new(reinterpret_cast<t_object*>(x), "multichannelsignal");
    } else {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), x->channels);
        for (long i = 0; i < x->channels; ++i) outlet_new(reinterpret_cast<t_object*>(x), "signal");
    }
    attr_args_process(x, argc, argv);
    prepare(x, sys_getsr());
    return x;
}

void free_object(t_s3g_arrayhpf* x) { dsp_free(reinterpret_cast<t_pxobject*>(x)); }

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.arrayhpf~", reinterpret_cast<method>(arrayhpf_new), reinterpret_cast<method>(free_object), sizeof(t_s3g_arrayhpf), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_activechannels), "activechannels", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_cutoff), "cutoff", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_poles), "poles", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_bypass), "bypass", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(dump), "dump", 0);
    CLASS_ATTR_DOUBLE(c, "activechannels", 0, t_s3g_arrayhpf, activechannels); CLASS_ATTR_ACCESSORS(c, "activechannels", nullptr, attr_activechannels); CLASS_ATTR_FILTER_CLIP(c, "activechannels", 1, 64);
    CLASS_ATTR_DOUBLE(c, "cutoff", 0, t_s3g_arrayhpf, cutoff); CLASS_ATTR_ACCESSORS(c, "cutoff", nullptr, attr_cutoff); CLASS_ATTR_FILTER_CLIP(c, "cutoff", 20, 240);
    CLASS_ATTR_DOUBLE(c, "poles", 0, t_s3g_arrayhpf, poles); CLASS_ATTR_ACCESSORS(c, "poles", nullptr, attr_poles); CLASS_ATTR_ENUMINDEX(c, "poles", 0, "6dB 12dB 18dB 24dB"); CLASS_ATTR_FILTER_CLIP(c, "poles", 1, 4);
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_arrayhpf, output); CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output); CLASS_ATTR_FILTER_CLIP(c, "output", -60, 18);
    CLASS_ATTR_DOUBLE(c, "bypass", 0, t_s3g_arrayhpf, bypass); CLASS_ATTR_ACCESSORS(c, "bypass", nullptr, attr_bypass); CLASS_ATTR_FILTER_CLIP(c, "bypass", 0, 1);
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_arrayhpf, mc);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_class = c;
}
