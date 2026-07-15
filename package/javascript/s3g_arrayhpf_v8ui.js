autowatch = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var model = {
    channels: 16,
    active: 16,
    poles: 2,
    cutoff: 90,
    output: 0,
    bypass: 0
};

function active(v) { model.active = clampInt(v, 1, model.channels); mgraphics.redraw(); }
function activechannels(v) { active(v); }
function cutoff(v) { model.cutoff = clamp(v, 20, 240); mgraphics.redraw(); }
function poles(v) { model.poles = clampInt(v, 1, 4); mgraphics.redraw(); }
function output(v) { model.output = clamp(v, -60, 18); mgraphics.redraw(); }
function bypass(v) { model.bypass = v ? 1 : 0; mgraphics.redraw(); }
function bang() { mgraphics.redraw(); }
function onresize() { mgraphics.redraw(); }

function config(channels, activeChannels, poleCount) {
    model.channels = clampInt(channels, 1, 64);
    model.active = clampInt(activeChannels, 1, model.channels);
    model.poles = clampInt(poleCount, 1, 4);
    mgraphics.redraw();
}

function state(cutoffHz, outputDb, isBypassed) {
    model.cutoff = clamp(cutoffHz, 20, 240);
    model.output = clamp(outputDb, -60, 18);
    model.bypass = isBypassed ? 1 : 0;
    mgraphics.redraw();
}

function anything() {
    var a = arrayfromargs(messagename, arguments);
    if (a[0] === "config") config(a[1], a[2], a[3]);
    else if (a[0] === "state") state(a[1], a[2], a[3]);
}

function paint() {
    var m = mgraphics;
    var w = box.rect[2] - box.rect[0];
    var h = box.rect[3] - box.rect[1];
    m.set_source_rgb(0.055, 0.055, 0.055);
    m.rectangle(0, 0, w, h);
    m.fill();

    var pad = 18;
    var gx = pad;
    var gy = pad;
    var gw = Math.max(20, w - pad * 2);
    var gh = Math.max(20, h - pad * 2 - 34);
    m.set_source_rgb(0.095, 0.095, 0.095);
    m.rectangle(gx, gy, gw, gh);
    m.fill();
    strokeRect(m, gx, gy, gw, gh, 0.28, 0.28, 0.28);

    drawGrid(m, gx, gy, gw, gh);
    drawResponse(m, gx, gy, gw, gh);
    drawLabels(m, gx, gy, gw, gh);
}

function drawGrid(m, x, y, w, h) {
    m.set_line_width(1);
    for (var i = 1; i < 4; i++) {
        var yy = y + h * i / 4;
        line(m, x, yy, x + w, yy, 0.18, 0.18, 0.18, 1);
    }
    var freqs = [20, 60, 120, 240, 1000, 10000];
    for (var f = 0; f < freqs.length; f++) {
        var xx = x + freqNorm(freqs[f]) * w;
        line(m, xx, y, xx, y + h, 0.14, 0.14, 0.14, 1);
    }
}

function drawResponse(m, x, y, w, h) {
    m.set_line_width(2);
    if (model.bypass) m.set_source_rgb(0.48, 0.48, 0.48);
    else m.set_source_rgb(0.78, 0.78, 0.78);
    var first = true;
    for (var i = 0; i <= 160; i++) {
        var n = i / 160;
        var hz = normFreq(n);
        var mag = hpfMagnitudeDb(hz, model.cutoff, model.poles) + model.output;
        if (model.bypass) mag = model.output;
        var yy = y + dbNorm(mag) * h;
        var xx = x + n * w;
        if (first) { m.move_to(xx, yy); first = false; }
        else m.line_to(xx, yy);
    }
    m.stroke();

    var cx = x + freqNorm(model.cutoff) * w;
    line(m, cx, y, cx, y + h, 0.68, 0.68, 0.68, 0.75);
}

function drawLabels(m, x, y, w, h) {
    text(m, model.cutoff.toFixed(0) + " Hz", x + freqNorm(model.cutoff) * w + 6, y + 14, 0.72, 0.72, 0.72, 9);
    text(m, (model.poles * 6) + " dB/oct", x + 6, y + h - 8, 0.62, 0.62, 0.62, 9);
}

function hpfMagnitudeDb(hz, cutoffHz, poles) {
    var r = Math.max(0.000001, hz / Math.max(1, cutoffHz));
    var onePole = r / Math.sqrt(1 + r * r);
    var mag = Math.pow(onePole, poles);
    return 20 * Math.log(Math.max(0.000001, mag)) / Math.LN10;
}

function freqNorm(hz) {
    return clamp((Math.log(hz) - Math.log(20)) / (Math.log(20000) - Math.log(20)), 0, 1);
}

function normFreq(n) {
    return Math.exp(Math.log(20) + clamp(n, 0, 1) * (Math.log(20000) - Math.log(20)));
}

function dbNorm(db) {
    return 1 - clamp((db + 48) / 54, 0, 1);
}

function line(m, x1, y1, x2, y2, r, g, b, a) {
    m.set_source_rgba(r, g, b, a);
    m.move_to(x1, y1);
    m.line_to(x2, y2);
    m.stroke();
}

function strokeRect(m, x, y, w, h, r, g, b) {
    m.set_source_rgb(r, g, b);
    m.set_line_width(1);
    m.rectangle(x + 0.5, y + 0.5, w - 1, h - 1);
    m.stroke();
}

function text(m, s, x, y, r, g, b, size) {
    m.select_font_face("Arial");
    m.set_font_size(size);
    m.set_source_rgb(r, g, b);
    m.move_to(x, y);
    m.show_text(String(s));
}

function clamp(v, lo, hi) {
    v = Number(v);
    if (!isFinite(v)) return lo;
    return Math.max(lo, Math.min(hi, v));
}

function clampInt(v, lo, hi) {
    return Math.round(clamp(v, lo, hi));
}
