autowatch = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var model = {
    inputs: 16,
    outputs: 2,
    order: 3,
    subs: 2,
    cutoff: 90,
    width: 1,
    output: 0,
    bypass: 0,
    subAz: []
};

function config(inputs, outputs, order, subs) {
    model.inputs = clampInt(inputs, 1, 64);
    model.outputs = clampInt(outputs, 1, 8);
    model.order = clampInt(order, 0, 7);
    model.subs = clampInt(subs, 1, model.outputs);
    mgraphics.redraw();
}

function params(cutoffHz, width, outputDb, bypass) {
    model.cutoff = clamp(cutoffHz, 20, 240);
    model.width = clamp(width, 0, 2);
    model.output = clamp(outputDb, -60, 18);
    model.bypass = bypass ? 1 : 0;
    mgraphics.redraw();
}

function sub(index, azimuth) {
    var i = clampInt(index, 1, 8) - 1;
    model.subAz[i] = Number(azimuth);
    mgraphics.redraw();
}

function cutoff(v) { model.cutoff = clamp(v, 20, 240); mgraphics.redraw(); }
function width(v) { model.width = clamp(v, 0, 2); mgraphics.redraw(); }
function subcount(v) { model.subs = clampInt(v, 1, model.outputs); mgraphics.redraw(); }
function bypass(v) { model.bypass = v ? 1 : 0; mgraphics.redraw(); }
function bang() { mgraphics.redraw(); }
function done() { mgraphics.redraw(); }

function anything() {
    var a = arrayfromargs(messagename, arguments);
    if (a[0] === "config") config(a[1], a[2], a[3], a[4]);
    else if (a[0] === "params") params(a[1], a[2], a[3], a[4]);
    else if (a[0] === "sub") sub(a[1], a[2]);
}

function paint() {
    var m = mgraphics;
    var w = box.rect[2] - box.rect[0];
    var h = box.rect[3] - box.rect[1];
    m.set_source_rgb(0.055, 0.055, 0.055);
    m.rectangle(0, 0, w, h);
    m.fill();

    var cx = w * 0.5;
    var cy = h * 0.52;
    var r = Math.min(w, h) * 0.34;
    m.set_source_rgb(0.095, 0.095, 0.095);
    m.rectangle(0, 0, w, h);
    m.fill();
    strokeRect(m, 0, 0, w, h, 0.28, 0.28, 0.28);
    circle(m, cx, cy, r, 0.22, 0.22, 0.22);
    text(m, "FRONT", cx - 18, 18, 0.62, 0.62, 0.62, 9);

    for (var i = 0; i < model.subs; i++) {
        var az = isFinite(model.subAz[i]) ? model.subAz[i] : -45 - i * 360 / Math.max(1, model.subs);
        var p = topPoint(cx, cy, r, az);
        square(m, p.x, p.y, 15, model.bypass ? 0.34 : 0.68, model.bypass ? 0.34 : 0.68, model.bypass ? 0.34 : 0.68);
        text(m, "S" + (i + 1), p.x + 10, p.y + 4, 0.82, 0.82, 0.82, 8);
    }

    text(m, model.cutoff.toFixed(0) + " Hz", 12, h - 28, 0.68, 0.68, 0.68, 9);
    text(m, "width " + model.width.toFixed(2), 88, h - 28, 0.68, 0.68, 0.68, 9);
    text(m, "order " + model.order, w - 58, h - 28, 0.68, 0.68, 0.68, 9);
}

function topPoint(cx, cy, r, az) {
    var rad = az * Math.PI / 180;
    return { x: cx - Math.sin(rad) * r, y: cy - Math.cos(rad) * r };
}

function square(m, x, y, size, r, g, b) {
    m.set_source_rgb(r, g, b);
    m.rectangle(x - size * 0.5, y - size * 0.5, size, size);
    m.fill();
    strokeRect(m, x - size * 0.5, y - size * 0.5, size, size, 0.9, 0.9, 0.9);
}

function circle(m, x, y, r, cr, cg, cb) {
    m.set_source_rgb(cr, cg, cb);
    m.set_line_width(1);
    m.ellipse(x - r, y - r, r * 2, r * 2);
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
