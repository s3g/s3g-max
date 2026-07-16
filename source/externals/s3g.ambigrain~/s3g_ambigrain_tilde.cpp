#include "ext.h"
#include "ext_buffer.h"
#include "ext_obex.h"
#include "z_dsp.h"

#include "s3g_ambi_grain_processor.h"

#include <algorithm>
#include <array>
#include <atomic>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <memory>
#include <new>
#include <string>
#include <vector>

namespace {

constexpr long kMaxChannels = s3g::kAmbiGrainChannels;

struct AmbiGrainImpl {
    s3g::AmbiGrainProcessor engine;
    s3g::AmbiGrainParams params {};
    std::shared_ptr<const s3g::AmbiGrainSample> sample;
    t_buffer_ref* bufferRef = nullptr;
    std::array<std::vector<float>, kMaxChannels> temp;
    double sampleRate = 48000.0;
    bool prepared = false;
    bool playing = true;
    bool refreshPending = false;
};

struct t_s3g_ambigrain {
    t_pxobject object;
    AmbiGrainImpl* impl = nullptr;
    void* infoOutlet = nullptr;
    t_symbol* buffername = nullptr;
    long mc = 0;
    double order = 3.0;
    double mode = 0.0;
    double density = 28.0;
    double grain = 90.0;
    double position = 0.0;
    double scan = 1.0;
    double jitter = 0.12;
    double rate = 1.0;
    double ratejitter = 0.04;
    double reverse = 0.0;
    double freeze = 0.5;
    double jumpsteps = 8.0;
    double sync = 1.0;
    double envelope = 0.0;
    double output = -12.0;
    double play = 1.0;
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

t_symbol* atom_symbol_at(long argc, t_atom* argv, long index, t_symbol* fallback)
{
    return argv && index < argc && atom_gettype(argv + index) == A_SYM ? atom_getsym(argv + index) : fallback;
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

uint32_t active_channels(const t_s3g_ambigrain* x)
{
    return s3g::ambiGrainChannelsForOrder(x && x->impl ? x->impl->params.order : 3u);
}

void notify_attr(t_s3g_ambigrain* x, const char* name)
{
    if (x && name) object_attr_touch(reinterpret_cast<t_object*>(x), gensym(name));
}

void sync_attrs(t_s3g_ambigrain* x)
{
    if (!x || !x->impl) return;
    const auto p = x->impl->params;
    x->order = p.order;
    x->mode = static_cast<double>(static_cast<uint32_t>(p.mode));
    x->density = p.density;
    x->grain = p.grainMs;
    x->position = p.sourcePosition;
    x->scan = p.scanSpeed;
    x->jitter = p.positionJitter;
    x->rate = p.rate;
    x->ratejitter = p.rateJitterOct;
    x->reverse = p.reverseChance;
    x->freeze = p.freezePosition;
    x->jumpsteps = p.jumpSteps;
    x->sync = p.sync ? 1.0 : 0.0;
    x->envelope = static_cast<double>(static_cast<uint32_t>(p.envelope));
    x->output = p.outputGainDb;
    x->play = x->impl->playing ? 1.0 : 0.0;
}

void dump(t_s3g_ambigrain* x)
{
    if (!x || !x->impl || !x->infoOutlet) return;
    sync_attrs(x);
    t_atom atoms[16];
    atom_setlong(atoms, static_cast<long>(x->impl->params.order));
    atom_setlong(atoms + 1, static_cast<long>(active_channels(x)));
    atom_setlong(atoms + 2, x->impl->sample ? static_cast<long>(x->impl->sample->channels) : 0);
    atom_setlong(atoms + 3, x->impl->sample ? static_cast<long>(x->impl->sample->frames) : 0);
    outlet_anything(x->infoOutlet, gensym("config"), 4, atoms);

    atom_setlong(atoms, static_cast<long>(x->impl->params.mode));
    atom_setfloat(atoms + 1, x->impl->params.density);
    atom_setfloat(atoms + 2, x->impl->params.grainMs);
    atom_setfloat(atoms + 3, x->impl->params.sourcePosition);
    atom_setfloat(atoms + 4, x->impl->params.scanSpeed);
    atom_setfloat(atoms + 5, x->impl->params.positionJitter);
    atom_setfloat(atoms + 6, x->impl->params.rate);
    atom_setfloat(atoms + 7, x->impl->params.outputGainDb);
    outlet_anything(x->infoOutlet, gensym("state"), 8, atoms);
    outlet_anything(x->infoOutlet, gensym("done"), 0, nullptr);
}

void apply(t_s3g_ambigrain* x)
{
    if (!x || !x->impl) return;
    x->impl->engine.setParams(x->impl->params);
    x->impl->params = x->impl->engine.params();
    sync_attrs(x);
    dump(x);
}

void prepare(t_s3g_ambigrain* x, double sampleRate)
{
    if (!x || !x->impl) return;
    x->impl->sampleRate = std::max(1.0, sampleRate);
    x->impl->engine.prepare(x->impl->sampleRate);
    x->impl->engine.setParams(x->impl->params);
    x->impl->prepared = true;
}

std::shared_ptr<s3g::AmbiGrainSample> snapshot_buffer(t_s3g_ambigrain* x)
{
    if (!x || !x->impl || !x->impl->bufferRef) return nullptr;
    t_buffer_obj* buffer = buffer_ref_getobject(x->impl->bufferRef);
    if (!buffer) {
        object_warn(reinterpret_cast<t_object*>(x), "no buffer~ named %s", x->buffername ? x->buffername->s_name : "");
        return nullptr;
    }
    float* samples = buffer_locksamples(buffer);
    if (!samples) {
        object_warn(reinterpret_cast<t_object*>(x), "could not lock buffer~");
        return nullptr;
    }
    const auto frameCount = buffer_getframecount(buffer);
    const auto channelCount = buffer_getchannelcount(buffer);
    const auto bufferSr = buffer_getsamplerate(buffer);
    if (frameCount < 8 || channelCount < 1) {
        buffer_unlocksamples(buffer);
        object_warn(reinterpret_cast<t_object*>(x), "buffer~ is empty or too short");
        return nullptr;
    }
    auto sample = std::make_shared<s3g::AmbiGrainSample>();
    sample->frames = static_cast<uint32_t>(frameCount);
    sample->channels = std::min<uint32_t>(s3g::kAmbiGrainChannels, static_cast<uint32_t>(channelCount));
    sample->sampleRate = bufferSr > 0.0 ? bufferSr : x->impl->sampleRate;
    sample->path = x->buffername ? x->buffername->s_name : "buffer~";
    sample->audio.assign(static_cast<size_t>(sample->frames) * sample->channels, 0.0f);
    for (uint32_t frame = 0; frame < sample->frames; ++frame) {
        for (uint32_t ch = 0; ch < sample->channels; ++ch) {
            sample->audio[static_cast<size_t>(frame) * sample->channels + ch] = samples[static_cast<size_t>(frame) * channelCount + ch];
        }
    }
    buffer_unlocksamples(buffer);
    return sample;
}

void refresh(t_s3g_ambigrain* x)
{
    if (!x || !x->impl) return;
    x->impl->refreshPending = false;
    auto sample = snapshot_buffer(x);
    if (!sample) {
        dump(x);
        return;
    }
    std::shared_ptr<const s3g::AmbiGrainSample> immutable = sample;
    std::atomic_store_explicit(&x->impl->sample, immutable, std::memory_order_release);
    x->impl->engine.reset();
    object_post(reinterpret_cast<t_object*>(x), "s3g.ambigrain~: loaded %u frames / %u channels", sample->frames, sample->channels);
    dump(x);
}

void refresh_deferred(t_s3g_ambigrain* x, t_symbol*, short, t_atom*)
{
    refresh(x);
}

void request_refresh(t_s3g_ambigrain* x)
{
    if (!x || !x->impl || x->impl->refreshPending) return;
    x->impl->refreshPending = true;
    defer_low(reinterpret_cast<t_object*>(x), reinterpret_cast<method>(refresh_deferred), nullptr, 0, nullptr);
}

void set_buffer(t_s3g_ambigrain* x, t_symbol* name)
{
    if (!x || !x->impl || !name) return;
    x->buffername = name;
    if (!x->impl->bufferRef) x->impl->bufferRef = buffer_ref_new(reinterpret_cast<t_object*>(x), name);
    else buffer_ref_set(x->impl->bufferRef, name);
    request_refresh(x);
    notify_attr(x, "buffer");
}

void msg_buffer(t_s3g_ambigrain* x, t_symbol* name) { set_buffer(x, name); }

void set_order(t_s3g_ambigrain* x, double v) { x->impl->params.order = static_cast<uint32_t>(std::clamp(std::floor(v + 0.5), 1.0, 3.0)); apply(x); notify_attr(x, "order"); }
void set_mode(t_s3g_ambigrain* x, double v) { x->impl->params.mode = static_cast<s3g::AmbiGrainMode>(static_cast<uint32_t>(std::clamp(std::floor(v + 0.5), 0.0, 3.0))); apply(x); notify_attr(x, "mode"); }
void set_density(t_s3g_ambigrain* x, double v) { x->impl->params.density = static_cast<float>(v); apply(x); notify_attr(x, "density"); }
void set_grain(t_s3g_ambigrain* x, double v) { x->impl->params.grainMs = static_cast<float>(v); apply(x); notify_attr(x, "grain"); }
void set_position(t_s3g_ambigrain* x, double v) { x->impl->params.sourcePosition = static_cast<float>(v); apply(x); notify_attr(x, "position"); }
void set_scan(t_s3g_ambigrain* x, double v)
{
    x->impl->params.scanSpeed = static_cast<float>(v);
    apply(x);
    notify_attr(x, "scan");
    notify_attr(x, "scanspeed");
}
void set_jitter(t_s3g_ambigrain* x, double v) { x->impl->params.positionJitter = static_cast<float>(v); apply(x); notify_attr(x, "jitter"); }
void set_rate(t_s3g_ambigrain* x, double v) { x->impl->params.rate = static_cast<float>(v); apply(x); notify_attr(x, "rate"); }
void set_ratejitter(t_s3g_ambigrain* x, double v) { x->impl->params.rateJitterOct = static_cast<float>(v); apply(x); notify_attr(x, "ratejitter"); }
void set_reverse(t_s3g_ambigrain* x, double v) { x->impl->params.reverseChance = static_cast<float>(v); apply(x); notify_attr(x, "reverse"); }
void set_freeze(t_s3g_ambigrain* x, double v) { x->impl->params.freezePosition = static_cast<float>(v); apply(x); notify_attr(x, "freeze"); }
void set_jumpsteps(t_s3g_ambigrain* x, double v) { x->impl->params.jumpSteps = static_cast<uint32_t>(std::clamp(std::floor(v + 0.5), 2.0, 64.0)); apply(x); notify_attr(x, "jumpsteps"); }
void set_sync(t_s3g_ambigrain* x, double v) { x->impl->params.sync = v != 0.0; apply(x); notify_attr(x, "sync"); }
void set_envelope(t_s3g_ambigrain* x, double v) { x->impl->params.envelope = static_cast<s3g::AmbiGrainEnvelope>(static_cast<uint32_t>(std::clamp(std::floor(v + 0.5), 0.0, 4.0))); apply(x); notify_attr(x, "envelope"); }
void set_output(t_s3g_ambigrain* x, double v) { x->impl->params.outputGainDb = static_cast<float>(v); apply(x); notify_attr(x, "output"); }
void set_play(t_s3g_ambigrain* x, double v) { x->impl->playing = v != 0.0; sync_attrs(x); dump(x); notify_attr(x, "play"); }

t_max_err attr_buffer(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_buffer(x, atom_symbol_at(argc, argv, 0, x->buffername)); return MAX_ERR_NONE; }
t_max_err attr_order(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_order(x, atom_double_at(argc, argv, 0, x->order)); return MAX_ERR_NONE; }
t_max_err attr_mode(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_mode(x, atom_double_at(argc, argv, 0, x->mode)); return MAX_ERR_NONE; }
t_max_err attr_density(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_density(x, atom_double_at(argc, argv, 0, x->density)); return MAX_ERR_NONE; }
t_max_err attr_grain(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_grain(x, atom_double_at(argc, argv, 0, x->grain)); return MAX_ERR_NONE; }
t_max_err attr_position(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_position(x, atom_double_at(argc, argv, 0, x->position)); return MAX_ERR_NONE; }
t_max_err attr_scan(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_scan(x, atom_double_at(argc, argv, 0, x->scan)); return MAX_ERR_NONE; }
t_max_err attr_scanspeed(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_scan(x, atom_double_at(argc, argv, 0, x->scan)); return MAX_ERR_NONE; }
t_max_err attr_jitter(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_jitter(x, atom_double_at(argc, argv, 0, x->jitter)); return MAX_ERR_NONE; }
t_max_err attr_rate(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_rate(x, atom_double_at(argc, argv, 0, x->rate)); return MAX_ERR_NONE; }
t_max_err attr_ratejitter(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_ratejitter(x, atom_double_at(argc, argv, 0, x->ratejitter)); return MAX_ERR_NONE; }
t_max_err attr_reverse(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_reverse(x, atom_double_at(argc, argv, 0, x->reverse)); return MAX_ERR_NONE; }
t_max_err attr_freeze(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_freeze(x, atom_double_at(argc, argv, 0, x->freeze)); return MAX_ERR_NONE; }
t_max_err attr_jumpsteps(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_jumpsteps(x, atom_double_at(argc, argv, 0, x->jumpsteps)); return MAX_ERR_NONE; }
t_max_err attr_sync(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_sync(x, atom_double_at(argc, argv, 0, x->sync)); return MAX_ERR_NONE; }
t_max_err attr_envelope(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_envelope(x, atom_double_at(argc, argv, 0, x->envelope)); return MAX_ERR_NONE; }
t_max_err attr_output(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_output(x, atom_double_at(argc, argv, 0, x->output)); return MAX_ERR_NONE; }
t_max_err attr_play(t_s3g_ambigrain* x, void*, long argc, t_atom* argv) { set_play(x, atom_double_at(argc, argv, 0, x->play)); return MAX_ERR_NONE; }

void perform64(t_s3g_ambigrain* x, t_object*, double**, long, double** outs, long numouts, long frames, long, void*)
{
    if (!x || !x->impl || !x->impl->prepared || !outs || frames <= 0) return;
    const uint32_t outChannels = std::min<uint32_t>({ active_channels(x), static_cast<uint32_t>(numouts), s3g::kAmbiGrainChannels });
    for (uint32_t ch = 0; ch < outChannels; ++ch) x->impl->temp[ch].assign(static_cast<size_t>(frames), 0.0f);
    std::array<float*, kMaxChannels> ptrs {};
    for (uint32_t ch = 0; ch < outChannels; ++ch) ptrs[ch] = x->impl->temp[ch].data();
    auto sample = std::atomic_load_explicit(&x->impl->sample, std::memory_order_acquire);
    x->impl->engine.setParams(x->impl->params);
    x->impl->engine.process(sample, ptrs.data(), outChannels, static_cast<uint32_t>(frames), x->impl->playing);
    for (uint32_t ch = 0; ch < outChannels; ++ch) {
        if (!outs[ch]) continue;
        for (long i = 0; i < frames; ++i) outs[ch][i] = x->impl->temp[ch][static_cast<size_t>(i)];
    }
    for (long ch = outChannels; ch < numouts; ++ch) {
        if (outs[ch]) std::fill(outs[ch], outs[ch] + frames, 0.0);
    }
}

void dsp64(t_s3g_ambigrain* x, t_object* dsp64, short*, double sampleRate, long, long)
{
    if (!x->impl->prepared || sampleRate != x->impl->sampleRate) prepare(x, sampleRate);
    if (!std::atomic_load_explicit(&x->impl->sample, std::memory_order_acquire)) request_refresh(x);
    object_method(dsp64, gensym("dsp_add64"), x, perform64, 0, nullptr);
}

void assist(t_s3g_ambigrain* x, void*, long msg, long index, char* text)
{
    if (msg == ASSIST_INLET) snprintf_zero(text, 256, "Signal sync input / messages");
    else if (x && x->mc && index == 0) snprintf_zero(text, 256, "MC ambisonic grain output");
    else if (index < active_channels(x)) snprintf_zero(text, 256, "Ambisonic output channel %ld", index + 1);
    else snprintf_zero(text, 256, "Info outlet");
}

long multichanneloutputs(t_s3g_ambigrain* x, long index) { return x && x->mc && index == 0 ? active_channels(x) : 0; }
long inputchanged(t_s3g_ambigrain*, long, long) { return false; }

void* ambigrain_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_s3g_ambigrain*>(object_alloc(s_class));
    if (!x) return nullptr;
    x->impl = new (std::nothrow) AmbiGrainImpl();
    if (!x->impl) {
        object_free(reinterpret_cast<t_object*>(x));
        return nullptr;
    }
    x->buffername = atom_symbol_at(argc, argv, 0, gensym(""));
    x->impl->params.order = static_cast<uint32_t>(std::clamp(atom_long_at(argc, argv, 1, 3), 1L, 3L));
    x->mc = attr_long_arg(argc, argv, "mc", 0) != 0 ? 1 : 0;
    x->infoOutlet = outlet_new(reinterpret_cast<t_object*>(x), nullptr);
    if (x->mc) {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), 1);
        x->object.z_misc |= Z_NO_INPLACE | Z_MC_INLETS;
        outlet_new(reinterpret_cast<t_object*>(x), "multichannelsignal");
    } else {
        dsp_setup(reinterpret_cast<t_pxobject*>(x), 1);
        for (long i = 0; i < kMaxChannels; ++i) outlet_new(reinterpret_cast<t_object*>(x), "signal");
    }
    attr_args_process(x, argc, argv);
    prepare(x, sys_getsr());
    if (x->buffername && x->buffername != gensym("")) set_buffer(x, x->buffername);
    else sync_attrs(x);
    return x;
}

void free_object(t_s3g_ambigrain* x)
{
    if (x && x->impl) {
        if (x->impl->bufferRef) object_free(x->impl->bufferRef);
        delete x->impl;
        x->impl = nullptr;
    }
    dsp_free(reinterpret_cast<t_pxobject*>(x));
}

} // namespace

extern "C" void ext_main(void*)
{
    t_class* c = class_new("s3g.ambigrain~", reinterpret_cast<method>(ambigrain_new), reinterpret_cast<method>(free_object), sizeof(t_s3g_ambigrain), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(dsp64), "dsp64", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(multichanneloutputs), "multichanneloutputs", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(inputchanged), "inputchanged", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(msg_buffer), "buffer", A_SYM, 0);
    class_addmethod(c, reinterpret_cast<method>(refresh), "refresh", 0);
    class_addmethod(c, reinterpret_cast<method>(set_order), "order", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_mode), "mode", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_density), "density", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_grain), "grain", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_position), "position", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_scan), "scan", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_scan), "scanspeed", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_jitter), "jitter", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_rate), "rate", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_ratejitter), "ratejitter", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_reverse), "reverse", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_freeze), "freeze", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_jumpsteps), "jumpsteps", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_sync), "sync", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_envelope), "envelope", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_output), "output", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(set_play), "play", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(dump), "dump", 0);
    CLASS_ATTR_SYM(c, "buffer", 0, t_s3g_ambigrain, buffername); CLASS_ATTR_ACCESSORS(c, "buffer", nullptr, attr_buffer);
    CLASS_ATTR_DOUBLE(c, "order", 0, t_s3g_ambigrain, order); CLASS_ATTR_ACCESSORS(c, "order", nullptr, attr_order); CLASS_ATTR_ENUMINDEX(c, "order", 0, "1OA 2OA 3OA"); CLASS_ATTR_FILTER_CLIP(c, "order", 1, 3);
    CLASS_ATTR_DOUBLE(c, "mode", 0, t_s3g_ambigrain, mode); CLASS_ATTR_ACCESSORS(c, "mode", nullptr, attr_mode); CLASS_ATTR_ENUMINDEX(c, "mode", 0, "scan cloud freeze jump"); CLASS_ATTR_FILTER_CLIP(c, "mode", 0, 3);
    CLASS_ATTR_DOUBLE(c, "density", 0, t_s3g_ambigrain, density); CLASS_ATTR_ACCESSORS(c, "density", nullptr, attr_density); CLASS_ATTR_FILTER_CLIP(c, "density", 0.1, 160);
    CLASS_ATTR_DOUBLE(c, "grain", 0, t_s3g_ambigrain, grain); CLASS_ATTR_ACCESSORS(c, "grain", nullptr, attr_grain); CLASS_ATTR_FILTER_CLIP(c, "grain", 8, 4000);
    CLASS_ATTR_DOUBLE(c, "position", 0, t_s3g_ambigrain, position); CLASS_ATTR_ACCESSORS(c, "position", nullptr, attr_position); CLASS_ATTR_FILTER_CLIP(c, "position", 0, 1);
    CLASS_ATTR_DOUBLE(c, "scan", 0, t_s3g_ambigrain, scan); CLASS_ATTR_ACCESSORS(c, "scan", nullptr, attr_scan); CLASS_ATTR_FILTER_CLIP(c, "scan", 0, 4);
    CLASS_ATTR_DOUBLE(c, "scanspeed", 0, t_s3g_ambigrain, scan); CLASS_ATTR_ACCESSORS(c, "scanspeed", nullptr, attr_scanspeed); CLASS_ATTR_FILTER_CLIP(c, "scanspeed", 0, 4);
    CLASS_ATTR_DOUBLE(c, "jitter", 0, t_s3g_ambigrain, jitter); CLASS_ATTR_ACCESSORS(c, "jitter", nullptr, attr_jitter); CLASS_ATTR_FILTER_CLIP(c, "jitter", 0, 1);
    CLASS_ATTR_DOUBLE(c, "rate", 0, t_s3g_ambigrain, rate); CLASS_ATTR_ACCESSORS(c, "rate", nullptr, attr_rate); CLASS_ATTR_FILTER_CLIP(c, "rate", 0.125, 4);
    CLASS_ATTR_DOUBLE(c, "ratejitter", 0, t_s3g_ambigrain, ratejitter); CLASS_ATTR_ACCESSORS(c, "ratejitter", nullptr, attr_ratejitter); CLASS_ATTR_FILTER_CLIP(c, "ratejitter", 0, 1);
    CLASS_ATTR_DOUBLE(c, "reverse", 0, t_s3g_ambigrain, reverse); CLASS_ATTR_ACCESSORS(c, "reverse", nullptr, attr_reverse); CLASS_ATTR_FILTER_CLIP(c, "reverse", 0, 1);
    CLASS_ATTR_DOUBLE(c, "freeze", 0, t_s3g_ambigrain, freeze); CLASS_ATTR_ACCESSORS(c, "freeze", nullptr, attr_freeze); CLASS_ATTR_FILTER_CLIP(c, "freeze", 0, 1);
    CLASS_ATTR_DOUBLE(c, "jumpsteps", 0, t_s3g_ambigrain, jumpsteps); CLASS_ATTR_ACCESSORS(c, "jumpsteps", nullptr, attr_jumpsteps); CLASS_ATTR_FILTER_CLIP(c, "jumpsteps", 2, 64);
    CLASS_ATTR_DOUBLE(c, "sync", 0, t_s3g_ambigrain, sync); CLASS_ATTR_ACCESSORS(c, "sync", nullptr, attr_sync); CLASS_ATTR_FILTER_CLIP(c, "sync", 0, 1);
    CLASS_ATTR_DOUBLE(c, "envelope", 0, t_s3g_ambigrain, envelope); CLASS_ATTR_ACCESSORS(c, "envelope", nullptr, attr_envelope); CLASS_ATTR_ENUMINDEX(c, "envelope", 0, "parzen sine hann triangle gauss"); CLASS_ATTR_FILTER_CLIP(c, "envelope", 0, 4);
    CLASS_ATTR_DOUBLE(c, "output", 0, t_s3g_ambigrain, output); CLASS_ATTR_ACCESSORS(c, "output", nullptr, attr_output); CLASS_ATTR_FILTER_CLIP(c, "output", -60, 6);
    CLASS_ATTR_DOUBLE(c, "play", 0, t_s3g_ambigrain, play); CLASS_ATTR_ACCESSORS(c, "play", nullptr, attr_play); CLASS_ATTR_FILTER_CLIP(c, "play", 0, 1);
    CLASS_ATTR_LONG(c, "mc", 0, t_s3g_ambigrain, mc);
    CLASS_ATTR_DEFAULT(c, "order", 0, "3"); CLASS_ATTR_SAVE(c, "order", 0);
    CLASS_ATTR_DEFAULT(c, "mode", 0, "0"); CLASS_ATTR_SAVE(c, "mode", 0);
    CLASS_ATTR_DEFAULT(c, "density", 0, "28."); CLASS_ATTR_SAVE(c, "density", 0);
    CLASS_ATTR_DEFAULT(c, "grain", 0, "90."); CLASS_ATTR_SAVE(c, "grain", 0);
    CLASS_ATTR_DEFAULT(c, "position", 0, "0."); CLASS_ATTR_SAVE(c, "position", 0);
    CLASS_ATTR_DEFAULT(c, "scan", 0, "1."); CLASS_ATTR_SAVE(c, "scan", 0);
    CLASS_ATTR_DEFAULT(c, "scanspeed", 0, "1.");
    CLASS_ATTR_DEFAULT(c, "jitter", 0, "0.12"); CLASS_ATTR_SAVE(c, "jitter", 0);
    CLASS_ATTR_DEFAULT(c, "rate", 0, "1."); CLASS_ATTR_SAVE(c, "rate", 0);
    CLASS_ATTR_DEFAULT(c, "ratejitter", 0, "0.04"); CLASS_ATTR_SAVE(c, "ratejitter", 0);
    CLASS_ATTR_DEFAULT(c, "reverse", 0, "0."); CLASS_ATTR_SAVE(c, "reverse", 0);
    CLASS_ATTR_DEFAULT(c, "freeze", 0, "0.5"); CLASS_ATTR_SAVE(c, "freeze", 0);
    CLASS_ATTR_DEFAULT(c, "jumpsteps", 0, "8"); CLASS_ATTR_SAVE(c, "jumpsteps", 0);
    CLASS_ATTR_DEFAULT(c, "sync", 0, "1"); CLASS_ATTR_SAVE(c, "sync", 0);
    CLASS_ATTR_DEFAULT(c, "envelope", 0, "0"); CLASS_ATTR_SAVE(c, "envelope", 0);
    CLASS_ATTR_DEFAULT(c, "output", 0, "-12."); CLASS_ATTR_SAVE(c, "output", 0);
    CLASS_ATTR_DEFAULT(c, "play", 0, "1"); CLASS_ATTR_SAVE(c, "play", 0);
    CLASS_ATTR_DEFAULT(c, "mc", 0, "0"); CLASS_ATTR_SAVE(c, "mc", 0);
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    s_class = c;
}
