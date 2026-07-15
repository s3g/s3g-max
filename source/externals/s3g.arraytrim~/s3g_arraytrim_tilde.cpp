#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_array_trim.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <new>

namespace {

constexpr long kDefaultChannels = 16;
constexpr long kMaxChannels = s3g::kArrayTrimMaxChannels;

struct ArrayTrimImpl {
    s3g::ArrayTrim trim;
    s3g::ArrayTrimParams params;
};

struct t_s3g_arraytrim {
    t_pxobject object;
    ArrayTrimImpl* impl = nullptr;
    void* infoOutlet = nullptr;
    long channels = kDefaultChannels;
    long mc = 0;
    bool prepared = false;
    double activechannels = kDefaultChannels;
    double selected = 1.0;
    double gaindb = 0.0;
    double mute = 0.0;
    double invert = 0.0;
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

void notify_attr(t_s3g_arraytrim* x, const char* name)
{
    if (!x || !name) return;
    object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

uint32_t selected_index(t_s3g_arraytrim* x)
{
    return static_cast<uint32_t>(std::clamp(x ? x->selected : 1.0, 1.0, static_cast<double>(x ? x->channels : kDefaultChannels))) - 1u;
}

void sync_attrs(t_s3g_arraytrim* x)
{
    if (!x || !x->impl) return;
    x->impl->params = x->impl->trim.params();
    x->activechannels = x->impl->params.activeChannels;
    x->selected = std::min<uint32_t>(static_cast<uint32_t>(std::max(1.0, x->selected)) - 1u, x->impl->params.activeChannels - 1u) + 1u;
    const uint32_t index = selected_index(x);
    x->gaindb = x->impl->params.gainDb[index];
    x->mute = x->impl->params.mute[index] ? 1.0 : 0.0;
    x->invert = x->impl->params.invert[index] ? 1.0 : 0.0;
    x->output = x->impl->params.outputGainDb;
    x->bypass = x->impl->params.bypass ? 1.0 : 0.0;
}

void dump(t_s3g_arraytrim* x)
{
    if (!x || !x->infoOutlet) return;
    sync_attrs(x);
    t_atom atoms[kMaxChannels];
    atom_setlong(atoms, x->channels);
    atom_setlong(atoms + 1, static_cast<long>(x->impl->params.activeChannels));
    atom_setlong(atoms + 2, static_cast<long>(x->selected));
    outlet_anything(x->infoOutlet, gensym("config"), 3, atoms);
    atom_setfloat(atoms, x->gaindb);
    atom_setfloat(atoms + 1, x->impl->params.outputGainDb);
    atom_setlong(atoms + 2, x->impl->params.mute[selected_index(x)] ? 1 : 0);
    atom_setlong(atoms + 3, x->impl->params.invert[selected_index(x)] ? 1 : 0);
    atom_setlong(atoms + 4, x->impl->params.bypass ? 1 : 0);
    outlet_anything(x->infoOutlet, gensym("state"), 5, atoms);
    const uint32_t n = std::min<uint32_t>(x->impl->params.activeChannels, static_cast<uint32_t>(x->channels));
    for (uint32_t i = 0; i < n; ++i) atom_setfloat(atoms + i, x->impl->params.gainDb[i]);
    outlet_anything(x->infoOutlet, gensym("gains"), static_cast<long>(n), atoms);
    for (uint32_t i = 0; i < n; ++i) atom_setlong(atoms + i, x->impl->params.mute[i] ? 1 : 0);
    outlet_anything(x->infoOutlet, gensym("mutes"), static_cast<long>(n), atoms);
    for (uint32_t i = 0; i < n; ++i) atom_setlong(atoms + i, x->impl->params.invert[i] ? 1 : 0);
    outlet_anything(x->infoOutlet, gensym("inverts"), static_cast<long>(n), atoms);
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

void apply(t_s3g_arraytrim* x)
{
    if (!x || !x->impl) return;
    x->impl->trim.setParams(x->impl->params);
    sync_attrs(x);
    dump(x);
}

void prepare(t_s3g_arraytrim* x, double sampleRate)
{
    if (!x || !x->impl) return;
    x->impl->trim.prepare(sampleRate);
    x->impl->trim.setParams(x->impl->params);
    x->prepared = true;
    sync_attrs(x);
}

void set_activechannels(t_s3g_arraytrim* x, double v) { x->impl->params.activeChannels = static_cast<uint32_t>(std::clamp(v, 1.0, static_cast<double>(x->channels))); apply(x); notify_attr(x, "activechannels"); }
void set_selected(t_s3g_arraytrim* x, double v) { x->selected = std::clamp(v, 1.0, static_cast<double>(x->channels)); sync_attrs(x); dump(x); notify_attr(x, "selected"); notify_attr(x, "gaindb"); notify_attr(x, "mute"); notify_attr(x, "invert"); }
void set_gaindb(t_s3g_arraytrim* x, double v) { x->impl->params.gainDb[selected_index(x)] = static_cast<float>(v); apply(x); notify_attr(x, "gaindb"); }
void set_mute(t_s3g_arraytrim* x, double v) { x->impl->params.mute[selected_index(x)] = v != 0.0 ? 1u : 0u; apply(x); notify_attr(x, "mute"); }
void set_invert(t_s3g_arraytrim* x, double v) { x->impl->params.invert[selected_index(x)] = v != 0.0 ? 1u : 0u; apply(x); notify_attr(x, "invert"); }
void set_output(t_s3g_arraytrim* x, double v) { x->impl->params.outputGainDb = static_cast<float>(v); apply(x); notify_attr(x, "output"); }
void set_bypass(t_s3g_arraytrim* x, double v) { x->impl->params.bypass = v != 0.0; apply(x); notify_attr(x, "bypass"); }

void msg_gain(t_s3g_arraytrim* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 2 || !argv) return;
    const uint32_t index = static_cast<uint32_t>(std::clamp(atom_long_at(argc, argv, 0, 1), 1L, x->channels)) - 1u;
    x->impl->params.gainDb[index] = static_cast<float>(atom_double_at(argc, argv, 1, 0.0));
    apply(x);
    if (index == selected_index(x)) notify_attr(x, "gaindb");
}

void msg_bool_at(t_s3g_arraytrim* x, t_symbol* s, long argc, t_atom* argv)
{
    if (!x || !s || argc < 1 || !argv) return;
    const uint32_t index = argc >= 2 ? static_cast<uint32_t>(std::clamp(atom_long_at(argc, argv, 0, 1), 1L, x->channels)) - 1u : selected_index(x);
    const uint8_t value = atom_double_at(argc, argv, argc >= 2 ? 1 : 0, 0.0) != 0.0 ? 1u : 0u;
    if (std::strcmp(s->s_name, "mute") == 0) x->impl->params.mute[index] = value;
    else x->impl->params.invert[index] = value;
    apply(x);
    if (index == selected_index(x)) notify_attr(x, std::strcmp(s->s_name, "mute") == 0 ? "mute" : "invert");
}

void msg_gains(t_s3g_arraytrim* x, t_symbol*, long argc, t_atom* argv)
{
    if (!x || argc < 1 || !argv) return;
    const uint32_t n = std::min<uint32_t>({ static_cast<uint32_t>(argc), static_cast<uint32_t>(x->channels), s3g::kArrayTrimMaxChannels });
    for (uint32_t i = 0; i < n; ++i) x->impl->params.gainDb[i] = static_cast<float>(atom_getfloat(argv + i));
    apply(x);
    notify_attr(x, "gaindb");
}

void msg_bool_list(t_s3g_arraytrim* x, t_symbol* s, long argc, t_atom* argv)
{
    if (!x || !s || argc < 1 || !argv) return;
    const uint32_t n = std::min<uint32_t>({ static_cast<uint32_t>(argc), static_cast<uint32_t>(x->channels), s3g::kArrayTrimMaxChannels });
    auto& target = std::strcmp(s->s_name, "mutes") == 0 ? x->impl->params.mute : x->impl->params.invert;
    for (uint32_t i = 0; i < n; ++i) target[i] = atom_getfloat(argv + i) != 0.0 ? 1u : 0u;
    apply(x);
    notify_attr(x, std::strcmp(s->s_name, "mutes") == 0 ? "mute" : "invert");
}

void msg_clear(t_s3g_arraytrim* x)
{
    if (!x || !x->impl) return;
    x->impl->params.gainDb.fill(0.0f);
    x->impl->params.mute.fill(0u);
    x->impl->params.invert.fill(0u);
    apply(x);
    notify_attr(x, "gaindb");
    notify_attr(x, "mute");
    notify_attr(x, "invert");
}

t_max_err attr_activechannels(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_activechannels(x, atom_double_at(argc, argv, 0, x->activechannels)); return MAX_ERR_NONE; }
t_max_err attr_selected(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_selected(x, atom_double_at(argc, argv, 0, x->selected)); return MAX_ERR_NONE; }
t_max_err attr_gaindb(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_gaindb(x, atom_double_at(argc, argv, 0, x->gaindb)); return MAX_ERR_NONE; }
t_max_err attr_mute(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_mute(x, atom_double_at(argc, argv, 0, x->mute)); return MAX_ERR_NONE; }
t_max_err attr_invert(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_invert(x, atom_double_at(argc, argv, 0, x->invert)); return MAX_ERR_NONE; }
t_max_err attr_output(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_bypass(t_s3g_arraytrim* x, void*, long argc, t_atom* argv) { set_bypass(x, atom_double_at(argc, argv, 0, x->bypass)); return MAX_ERR_NONE; }

void perform64(t_s3g_arraytrim* x, t_object*, double** ins, long numins, double** outs, long numouts, long frames, long, void*)
{
    if (!x || !x->impl || !x->prepared) return;
    const long inCount = std::min<long>({ x->channels, numins, kMaxChannels });
    const long outCount = std::min<long>({ x->channels, numouts, kMaxChannels });
    x->impl->trim.processBlock(ins, outs, static_cast<uint32_t>(inCount), static_cast<uint32_t>(outCount), static_cast<uint32_t>(frames));
    for (long ch = outCount; ch < numouts; ++ch) {
        if (outs[ch]) std::fill(outs[ch], outs[ch] + frames, 0.0);
    }
}

void dsp64(t_s3g_arraytrim* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x || !x->impl) return;
    if (!x->prepared) prepare(x, sampleRate);
    object_method(dsp64, gensym("dsp_add64"), x, perform64, 0, nullptr);
}

void assist(t_s3g_arraytrim* x, void*, long msg, long index, char* text)
{
    if (msg == ASSIST_INLET) snprintf_zero(text, 256, x && x->mc ? "MC speaker array input / messages" : "Speaker array signal input %ld / messages", index + 1);
    else if (x && x->mc && index == 0) snprintf_zero(text, 256, "MC trimmed speaker array output");
    else if (index < (x ? x->channels : 0)) snprintf_zero(text, 256, "Trimmed speaker output %ld", index + 1);
    else snprintf_zero(text, 256, "Info outlet");
}

long multichanneloutputs(t_s3g_arraytrim* x, long index)
{
    return x && x->mc && index == 0 ? x->channels : 0;
}

long inputchanged(t_s3g_arraytrim*, long, long) { return false; }

void* arraytrim_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_arraytrim*>(object_alloc(s_class));
    if (!x) return nullptr;
    x->impl = new (std::nothrow) ArrayTrimImpl();
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

void free_object(t_s3g_arraytrim* x) { dsp_free(reinterpret_cast<t_pxobject*>(x)); delete x->impl; x->impl = nullptr; }

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.arraytrim~", reinterpret_cast<method>(arraytrim_new), reinterpret_cast<method>(free_object), sizeof(t_s3g_arraytrim), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_activechannels), "activechannels", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_selected), "select", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_gaindb), "gaindb", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_bypass), "bypass", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_gain), "gain", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_gain), "trim", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_bool_at), "mute", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_bool_at), "invert", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_gains), "gains", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_gains), "list", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_bool_list), "mutes", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_bool_list), "inverts", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_clear), "clear", 0);
    class_addmethod(c, reinterpret_cast<method>(dump), "dump", 0);
    CLASS_ATTR_DOUBLE(c, "activechannels", 0, t_s3g_arraytrim, activechannels); CLASS_ATTR_ACCESSORS(c, "activechannels", nullptr, attr_activechannels); CLASS_ATTR_FILTER_CLIP(c, "activechannels", 1, 64);
    CLASS_ATTR_DOUBLE(c, "selected", 0, t_s3g_arraytrim, selected); CLASS_ATTR_ACCESSORS(c, "selected", nullptr, attr_selected); CLASS_ATTR_FILTER_CLIP(c, "selected", 1, 64);
    CLASS_ATTR_DOUBLE(c, "gaindb", 0, t_s3g_arraytrim, gaindb); CLASS_ATTR_ACCESSORS(c, "gaindb", nullptr, attr_gaindb); CLASS_ATTR_FILTER_CLIP(c, "gaindb", -60, 18);
    CLASS_ATTR_DOUBLE(c, "mute", 0, t_s3g_arraytrim, mute); CLASS_ATTR_ACCESSORS(c, "mute", nullptr, attr_mute); CLASS_ATTR_FILTER_CLIP(c, "mute", 0, 1);
    CLASS_ATTR_DOUBLE(c, "invert", 0, t_s3g_arraytrim, invert); CLASS_ATTR_ACCESSORS(c, "invert", nullptr, attr_invert); CLASS_ATTR_FILTER_CLIP(c, "invert", 0, 1);
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_arraytrim, output); CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output); CLASS_ATTR_FILTER_CLIP(c, "output", -60, 18);
    CLASS_ATTR_DOUBLE(c, "bypass", 0, t_s3g_arraytrim, bypass); CLASS_ATTR_ACCESSORS(c, "bypass", nullptr, attr_bypass); CLASS_ATTR_FILTER_CLIP(c, "bypass", 0, 1);
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_arraytrim, mc);
    CLASS_ATTR_DEFAULT(c, "activechannels", 0, "16"); CLASS_ATTR_SAVE(c, "activechannels", 0);
    CLASS_ATTR_DEFAULT(c, "selected", 0, "1"); CLASS_ATTR_SAVE(c, "selected", 0);
    CLASS_ATTR_DEFAULT(c, "gaindb", 0, "0."); CLASS_ATTR_SAVE(c, "gaindb", 0);
    CLASS_ATTR_DEFAULT(c, "mute", 0, "0"); CLASS_ATTR_SAVE(c, "mute", 0);
    CLASS_ATTR_DEFAULT(c, "invert", 0, "0"); CLASS_ATTR_SAVE(c, "invert", 0);
    CLASS_ATTR_DEFAULT(c, "output", 0, "0."); CLASS_ATTR_SAVE(c, "output", 0);
    CLASS_ATTR_DEFAULT(c, "bypass", 0, "0"); CLASS_ATTR_SAVE(c, "bypass", 0);
    CLASS_ATTR_DEFAULT(c, "mc", 0, "0"); CLASS_ATTR_SAVE(c, "mc", 0);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_class = c;
}
