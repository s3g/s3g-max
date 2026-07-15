#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_array_delay.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <new>

namespace {

constexpr long kDefaultChannels = 16;
constexpr long kMaxChannels = s3g::kArrayDelayMaxChannels;

struct ArrayDelayImpl {
    s3g::ArrayDelay delay;
    s3g::ArrayDelayParams params;
};

struct t_s3g_arraydelay {
    t_pxobject object;
    ArrayDelayImpl* impl = nullptr;
    void* infoOutlet = nullptr;
    long channels = kDefaultChannels;
    long mc = 0;
    double sampleRate = 48000.0;
    bool prepared = false;
    double activechannels = kDefaultChannels;
    double selected = 1.0;
    double delayms = 0.0;
    double maxdelay = s3g::kArrayDelayDefaultMaxMs;
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

void notify_attr(t_s3g_arraydelay* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void sync_attrs(t_s3g_arraydelay* x)
{
    if (!x || !x->impl) return;
    x->impl->params = x->impl->delay.params();
    x->activechannels = x->impl->params.activeChannels;
    x->selected = std::min<uint32_t>(static_cast<uint32_t>(std::max(1.0, x->selected)) - 1u, x->impl->params.activeChannels - 1u) + 1u;
    x->delayms = x->impl->params.delayMs[static_cast<uint32_t>(x->selected) - 1u];
    x->maxdelay = x->impl->params.maxDelayMs;
    x->output = x->impl->params.outputGainDb;
    x->bypass = x->impl->params.bypass ? 1.0 : 0.0;
}

void dump(t_s3g_arraydelay* x)
{
    if (!x || !x->infoOutlet) return;
    sync_attrs(x);
    t_atom atoms[kMaxChannels];
    atom_setlong(atoms, x->channels);
    atom_setlong(atoms + 1, static_cast<long>(x->impl->params.activeChannels));
    atom_setlong(atoms + 2, static_cast<long>(x->selected));
    outlet_anything(x->infoOutlet, gensym("config"), 3, atoms);
    atom_setfloat(atoms, x->delayms);
    atom_setfloat(atoms + 1, x->impl->params.maxDelayMs);
    atom_setfloat(atoms + 2, x->impl->params.outputGainDb);
    atom_setlong(atoms + 3, x->impl->params.bypass ? 1 : 0);
    outlet_anything(x->infoOutlet, gensym("state"), 4, atoms);
    const uint32_t n = std::min<uint32_t>(x->impl->params.activeChannels, static_cast<uint32_t>(x->channels));
    for (uint32_t i = 0; i < n; ++i) atom_setfloat(atoms + i, x->impl->params.delayMs[i]);
    outlet_anything(x->infoOutlet, gensym("delays"), static_cast<long>(n), atoms);
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

void apply(t_s3g_arraydelay* x)
{
    if (!x || !x->impl) return;
    x->impl->delay.setParams(x->impl->params);
    sync_attrs(x);
    dump(x);
}

void prepare(t_s3g_arraydelay* x, double sampleRate)
{
    if (!x || !x->impl) return;
    x->sampleRate = std::max(1.0, sampleRate);
    x->impl->delay.prepare(x->sampleRate);
    x->impl->delay.setParams(x->impl->params);
    x->prepared = true;
    sync_attrs(x);
}

void set_activechannels(t_s3g_arraydelay* x, double v) { x->impl->params.activeChannels = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(x->channels))); apply(x); notify_attr(x, "activechannels"); }
void set_selected(t_s3g_arraydelay* x, double v) { x->selected = std::clamp(v, 1.0, static_cast<double>(x->channels)); sync_attrs(x); dump(x); notify_attr(x, "selected"); notify_attr(x, "delayms"); }
void set_delayms(t_s3g_arraydelay* x, double v) { const auto index = static_cast<uint32_t>(std::clamp(x->selected, 1.0, static_cast<double>(x->channels))) - 1u; x->impl->params.delayMs[index] = static_cast<float>(v); apply(x); notify_attr(x, "delayms"); }
void set_maxdelay(t_s3g_arraydelay* x, double v) { x->impl->params.maxDelayMs = static_cast<float>(v); apply(x); notify_attr(x, "maxdelay"); notify_attr(x, "delayms"); }
void set_output(t_s3g_arraydelay* x, double v) { x->impl->params.outputGainDb = static_cast<float>(v); apply(x); notify_attr(x, "output"); }
void set_bypass(t_s3g_arraydelay* x, double v) { x->impl->params.bypass = v != 0.0; apply(x); notify_attr(x, "bypass"); }

void msg_delay(t_s3g_arraydelay* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 2 || !argv) return;
    const uint32_t index = static_cast<uint32_t>(std::clamp(atom_long_at(argc, argv, 0, 1), 1L, x->channels)) - 1u;
    x->impl->params.delayMs[index] = static_cast<float>(atom_double_at(argc, argv, 1, 0.0));
    apply(x);
    if (index == static_cast<uint32_t>(x->selected) - 1u) notify_attr(x, "delayms");
}

void msg_delays(t_s3g_arraydelay* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return;
    const uint32_t n = std::min<uint32_t>({ static_cast<uint32_t>(argc), static_cast<uint32_t>(x->channels), s3g::kArrayDelayMaxChannels });
    for (uint32_t i = 0; i < n; ++i) x->impl->params.delayMs[i] = static_cast<float>(atom_getfloat(argv + i));
    apply(x);
    notify_attr(x, "delayms");
}

t_max_err attr_activechannels(t_s3g_arraydelay* x, void*, long argc, t_atom* argv) { set_activechannels(x, atom_double_at(argc, argv, 0, x->activechannels)); return MAX_ERR_NONE; }
t_max_err attr_selected(t_s3g_arraydelay* x, void*, long argc, t_atom* argv) { set_selected(x, atom_double_at(argc, argv, 0, x->selected)); return MAX_ERR_NONE; }
t_max_err attr_delayms(t_s3g_arraydelay* x, void*, long argc, t_atom* argv) { set_delayms(x, atom_double_at(argc, argv, 0, x->delayms)); return MAX_ERR_NONE; }
t_max_err attr_maxdelay(t_s3g_arraydelay* x, void*, long argc, t_atom* argv) { set_maxdelay(x, atom_double_at(argc, argv, 0, x->maxdelay)); return MAX_ERR_NONE; }
t_max_err attr_output(t_s3g_arraydelay* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_bypass(t_s3g_arraydelay* x, void*, long argc, t_atom* argv) { set_bypass(x, atom_double_at(argc, argv, 0, x->bypass)); return MAX_ERR_NONE; }

void perform64(t_s3g_arraydelay* x, t_object*, double** ins, long numins, double** outs, long numouts, long frames, long, void*)
{
    if (!x || !x->impl || !x->prepared) return;
    const long inCount = std::min<long>({ x->channels, numins, kMaxChannels });
    const long outCount = std::min<long>({ x->channels, numouts, kMaxChannels });
    x->impl->delay.processBlock(ins, outs, static_cast<uint32_t>(inCount), static_cast<uint32_t>(outCount), static_cast<uint32_t>(frames));
    for (long ch = outCount; ch < numouts; ++ch) {
        if (outs[ch]) std::fill(outs[ch], outs[ch] + frames, 0.0);
    }
}

void dsp64(t_s3g_arraydelay* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x || !x->impl) return;
    if (!x->prepared || sampleRate != x->sampleRate) prepare(x, sampleRate);
    object_method(dsp64, gensym("dsp_add64"), x, perform64, 0, nullptr);
}

void assist(t_s3g_arraydelay* x, void*, long msg, long index, char* text)
{
    if (msg == ASSIST_INLET) snprintf_zero(text, 256, x && x->mc ? "MC speaker array input / messages" : "Speaker array signal input %ld / messages", index + 1);
    else if (x && x->mc && index == 0) snprintf_zero(text, 256, "MC delayed speaker array output");
    else if (index < (x ? x->channels : 0)) snprintf_zero(text, 256, "Delayed speaker output %ld", index + 1);
    else snprintf_zero(text, 256, "Info outlet");
}

long multichanneloutputs(t_s3g_arraydelay* x, long index)
{
    return x && x->mc && index == 0 ? x->channels : 0;
}

long inputchanged(t_s3g_arraydelay*, long, long) { return false; }

void* arraydelay_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_arraydelay*>(object_alloc(s_class));
    if (!x) return nullptr;
    x->impl = new (std::nothrow) ArrayDelayImpl();
    if (!x->impl) {
        object_free(reinterpret_cast<t_object*>(x));
        return nullptr;
    }
    x->channels = std::clamp(atom_long_at(argc, argv, 0, kDefaultChannels), 1L, kMaxChannels);
    x->mc = attr_long_arg(argc, argv, "mc", 0) != 0 ? 1 : 0;
    x->impl->params.activeChannels = static_cast<uint32_t>(x->channels);
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

void free_object(t_s3g_arraydelay* x) { dsp_free(reinterpret_cast<t_pxobject*>(x)); delete x->impl; x->impl = nullptr; }

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.arraydelay~", reinterpret_cast<method>(arraydelay_new), reinterpret_cast<method>(free_object), sizeof(t_s3g_arraydelay), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_activechannels), "activechannels", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_selected), "select", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_delayms), "delayms", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_maxdelay), "maxdelay", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_bypass), "bypass", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_delay), "delay", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_delays), "delays", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_delays), "list", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dump), "dump", 0);
    CLASS_ATTR_DOUBLE(c, "activechannels", 0, t_s3g_arraydelay, activechannels); CLASS_ATTR_ACCESSORS(c, "activechannels", nullptr, attr_activechannels); CLASS_ATTR_FILTER_CLIP(c, "activechannels", 1, 64);
    CLASS_ATTR_DOUBLE(c, "selected", 0, t_s3g_arraydelay, selected); CLASS_ATTR_ACCESSORS(c, "selected", nullptr, attr_selected); CLASS_ATTR_FILTER_CLIP(c, "selected", 1, 64);
    CLASS_ATTR_DOUBLE(c, "delayms", 0, t_s3g_arraydelay, delayms); CLASS_ATTR_ACCESSORS(c, "delayms", nullptr, attr_delayms); CLASS_ATTR_FILTER_CLIP(c, "delayms", 0, 1000);
    CLASS_ATTR_DOUBLE(c, "maxdelay", 0, t_s3g_arraydelay, maxdelay); CLASS_ATTR_ACCESSORS(c, "maxdelay", nullptr, attr_maxdelay); CLASS_ATTR_FILTER_CLIP(c, "maxdelay", 1, 1000);
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_arraydelay, output); CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output); CLASS_ATTR_FILTER_CLIP(c, "output", -60, 18);
    CLASS_ATTR_DOUBLE(c, "bypass", 0, t_s3g_arraydelay, bypass); CLASS_ATTR_ACCESSORS(c, "bypass", nullptr, attr_bypass); CLASS_ATTR_FILTER_CLIP(c, "bypass", 0, 1);
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_arraydelay, mc);
    CLASS_ATTR_DEFAULT(c, "activechannels", 0, "16"); CLASS_ATTR_SAVE(c, "activechannels", 0);
    CLASS_ATTR_DEFAULT(c, "selected", 0, "1"); CLASS_ATTR_SAVE(c, "selected", 0);
    CLASS_ATTR_DEFAULT(c, "delayms", 0, "0."); CLASS_ATTR_SAVE(c, "delayms", 0);
    CLASS_ATTR_DEFAULT(c, "maxdelay", 0, "4000."); CLASS_ATTR_SAVE(c, "maxdelay", 0);
    CLASS_ATTR_DEFAULT(c, "output", 0, "0."); CLASS_ATTR_SAVE(c, "output", 0);
    CLASS_ATTR_DEFAULT(c, "bypass", 0, "0"); CLASS_ATTR_SAVE(c, "bypass", 0);
    CLASS_ATTR_DEFAULT(c, "mc", 0, "0"); CLASS_ATTR_SAVE(c, "mc", 0);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_class = c;
}
