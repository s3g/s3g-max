autowatch = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var viewSize = { w: 520, h: 320 };
var model = {
    layout: "quad",
    layoutIndex: 9,
    mode: "split",
    channels: 6,
    high: 4,
    subs: 1,
    offset: 5,
    cutoff: 90,
    focus: 1.5,
    subgain: 0,
    highgain: 0,
    bypass: 0,
    foldbypass: 1
};

function active(v) { mgraphics.redraw(); }
function onresize(w, h) { viewSize.w = w; viewSize.h = h; mgraphics.redraw(); }
function bang() { mgraphics.redraw(); }

function layout(indexOrName, name) {
    if (typeof name === "string") {
        model.layoutIndex = Math.max(0, Math.min(25, Math.round(indexOrName)));
        model.layout = normalizeLayoutName(name);
    } else if (typeof indexOrName === "number") {
        model.layoutIndex = Math.max(0, Math.min(25, Math.round(indexOrName)));
        model.layout = layoutNameForIndex(model.layoutIndex);
    } else {
        model.layout = normalizeLayoutName(indexOrName);
        model.layoutIndex = layoutIndexForName(model.layout);
    }
    var counts = layoutCounts(model.layout);
    if (counts.high > 0) model.high = counts.high;
    if (model.offset <= model.high) model.offset = Math.min(64, model.high + 1);
    mgraphics.redraw();
}

function mode(indexOrName, name) {
    var v = typeof name === "string" ? name : indexOrName;
    if (typeof v === "number") model.mode = v >= 0.5 ? "send" : "split";
    else model.mode = (String(v).toLowerCase() === "send") ? "send" : "split";
    mgraphics.redraw();
}

function stateMessage(channels, high, subs, offset, cutoff, focus, subgain, highgain, bypass, foldbypass) {
    model.channels = clampInt(channels, 1, 64);
    model.high = clampInt(high, 1, 64);
    model.subs = clampInt(subs, 1, 8);
    model.offset = clampInt(offset, 1, 64);
    model.cutoff = clamp(cutoff, 20, 240);
    model.focus = clamp(focus, 0.25, 8);
    model.subgain = clamp(subgain, -60, 18);
    model.highgain = clamp(highgain, -60, 18);
    model.bypass = bypass ? 1 : 0;
    model.foldbypass = foldbypass ? 1 : 0;
    mgraphics.redraw();
}

function state() {
    stateMessage.apply(this, arrayfromargs(arguments));
}

function highchannels(v) { model.high = clampInt(v, 1, 64); mgraphics.redraw(); }
function subcount(v) { model.subs = clampInt(v, 1, 8); mgraphics.redraw(); }
function suboffset(v) { model.offset = clampInt(v, 1, 64); mgraphics.redraw(); }
function cutoff(v) { model.cutoff = clamp(v, 20, 240); mgraphics.redraw(); }
function subfocus(v) { model.focus = clamp(v, 0.25, 8); mgraphics.redraw(); }
function subgain(v) { model.subgain = clamp(v, -60, 18); mgraphics.redraw(); }
function highgain(v) { model.highgain = clamp(v, -60, 18); mgraphics.redraw(); }
function bypass(v) { model.bypass = v ? 1 : 0; mgraphics.redraw(); }
function foldbypass(v) { model.foldbypass = v ? 1 : 0; mgraphics.redraw(); }

function anything() {
    var a = arrayfromargs(messagename, arguments);
    if (a[0] === "state") stateMessage.apply(this, a.slice(1));
}

function paint() {
    var m = mgraphics;
    var w = box.rect[2] - box.rect[0];
    var h = box.rect[3] - box.rect[1];
    m.set_source_rgb(0.055, 0.055, 0.055);
    m.rectangle(0, 0, w, h);
    m.fill();

    drawField(m, 0, 0, w, h);
}

function drawField(m, x, y, w, h) {
    m.set_source_rgb(0.095, 0.095, 0.095);
    m.rectangle(x, y, w, h);
    m.fill();
    strokeRect(m, x, y, w, h, 0.28, 0.28, 0.28);

    var cx = x + w * 0.5;
    var cy = y + h * 0.54;
    var r = Math.min(w, h) * 0.35;
    text(m, "FRONT", cx - 18, y + 18, 0.62, 0.62, 0.62, 9);

    var speakers = speakerPositions(model.layout, model.high);
    var projected = [];
    for (var i = 0; i < speakers.length; i++) {
        var p = topViewPoint(cx, cy, r, speakers[i]);
        projected.push({ id: i + 1, speaker: speakers[i], x: p.x, y: p.y });
    }

    if (name === "dodeca12" || name === "icosahedron20") drawPolyhedronShell(m, cx, cy, r, name);
    else drawLayoutEdges(m, projected);

    for (var i = 0; i < projected.length; i++) {
        var p = projected[i];
        square(m, p.x, p.y, 8, 0.48, 0.48, 0.48, 0.82, 0.82, 0.82);
    }
    drawGroupedSpeakerLabels(m, projected);

    for (var s = 0; s < model.subs; s++) {
        var az = wrapDeg(-45 - s * 360 / Math.max(1, model.subs));
        var sp = topViewPoint(cx, cy, r, { az: az, el: 0, distance: 1.2 });
        square(m, sp.x, sp.y, 14, 0.72, 0.72, 0.72, 1, 1, 1);
        text(m, "S" + (model.offset + s), sp.x + 10, sp.y + 4, 0.86, 0.86, 0.86, 8);
    }

}

function drawGroupedSpeakerLabels(m, projected) {
    var used = [];
    for (var i = 0; i < projected.length; i++) used[i] = 0;
    for (var p = 0; p < projected.length; p++) {
        if (used[p]) continue;
        used[p] = 1;
        var label = String(projected[p].id);
        for (var q = p + 1; q < projected.length; q++) {
            if (used[q]) continue;
            if (!pointsOverlap(projected[p], projected[q])) continue;
            used[q] = 1;
            label += "/" + projected[q].id;
        }
        text(m, label, projected[p].x + 7, projected[p].y + 4, 0.68, 0.68, 0.68, 8);
    }
}

function pointsOverlap(a, b) {
    return Math.abs(a.x - b.x) <= 1.5 && Math.abs(a.y - b.y) <= 1.5;
}

function speakerPositions(name, count) {
    name = normalizeLayoutName(name);
    var base = layoutAeds(name, count);
    var out = [];
    for (var i = 0; i < count; i++) {
        out.push(base[i] || { az: wrapDeg(-30 - i * 360 / count), el: 0, distance: 1 });
        out[i].id = i + 1;
    }
    return out;
}

function layoutAeds(name, count) {
    var base = [];
    if (name === "5.0" || name === "5.0.2" || name === "5.0.4") base = bedAeds([-30, -110, 110, 30, 0]);
    else if (name === "6.0") base = bedAeds([-30, -110, 180, 110, 30, 0]);
    else if (name === "7.0" || name === "7.0.2" || name === "7.0.4" || name === "7.0.6") base = bedAeds([-30, -110, -150, 150, 110, 30, 0]);
    else if (name === "9.0" || name === "9.0.2" || name === "9.0.4" || name === "9.0.6") base = bedAeds([-30, -60, -110, -150, 150, 110, 60, 30, 0]);
    else if (name === "11.0.8") base = bedAeds([-30, -50, -70, -110, -150, 180, 150, 110, 70, 30, 0]);
    else if (name === "quad") base = bedAeds([45, -45, -135, 135]);
    else if (name === "quad+oh") base = bedAeds([45, -45, -135, 135]).concat([
        { az: 90, el: 60, distance: 1 },
        { az: -90, el: 60, distance: 1 }
    ]);
    else if (name === "cube8") base = cube8Aeds();
    else if (name === "cube17") base = cube17Aeds();
    else if (name === "cube41") base = aedsFromXyz(cube41Xyz());
    else if (name === "lpac41") base = aedsFromXyz(lpac41Xyz());
    else if (name === "dodeca12") base = dodecaAeds();
    else if (name === "icosahedron20") base = icosahedron20Aeds();
    else if (name === "double16") base = bedAeds(ring(8)).concat(elevatedRing(8, 45, 1));
    else if (name === "double20") base = bedAeds(ring(12)).concat(elevatedRing(8, 45, 1));
    else if (name === "octo") base = bedAeds(ringFrom(-45, count));
    else if (name === "ring12" || name === "ring16") base = bedAeds(ring(count));
    else if (name === "dome24" || name === "dome25") base = srstDomeAeds(name === "dome25");
    else if (name === "srst25") base = normalizeAedDistances(aedsFromRoomXyz(srst25Xyz()));
    else base = bedAeds(ring(count));
    var height = (name === "quad+oh") ? 0 : heightCountForLayout(name);
    if (height > 0) base = base.concat(overheadAzimuths(height));
    return base;
}

function bedAeds(azimuths) {
    var out = [];
    for (var i = 0; i < azimuths.length; i++) out.push({ az: azimuths[i], el: 0, distance: 1 });
    return out;
}

function cube8Aeds() {
    var pts = [
        [1, -1, -1], [-1, -1, -1], [-1, 1, -1], [1, 1, -1],
        [1, -1, 1], [-1, -1, 1], [-1, 1, 1], [1, 1, 1]
    ];
    return aedsFromXyz(pts);
}

function cube17Aeds() {
    var pts = [
        [1, -1, -1], [-1, -1, -1], [-1, 1, -1], [1, 1, -1],
        [1, -1, 0], [0, -1, 0], [-1, -1, 0], [-1, 0, 0],
        [-1, 1, 0], [0, 1, 0], [1, 1, 0], [1, 0, 0],
        [1, -1, 1], [-1, -1, 1], [-1, 1, 1], [1, 1, 1],
        [0, 0, 1]
    ];
    return aedsFromXyz(pts);
}

function cube41Xyz() {
    return [
        [-0.6,1,0],[-0.2,1,0],[0.2,1,0],[0.6,1,0],[1,0.6,0],[1,0.2,0],[1,-0.2,0],[1,-0.6,0],
        [0.6,-1,0],[0.2,-1,0],[-0.2,-1,0],[-0.6,-1,0],[-1,-0.6,0],[-1,-0.2,0],[-1,0.2,0],[-1,0.6,0],
        [-0.45,1,0.3333333333],[0,1,0.3333333333],[0.45,1,0.3333333333],
        [1,0.45,0.3333333333],[1,0,0.3333333333],[1,-0.45,0.3333333333],
        [0.45,-1,0.3333333333],[0,-1,0.3333333333],[-0.45,-1,0.3333333333],
        [-1,-0.45,0.3333333333],[-1,0,0.3333333333],[-1,0.45,0.3333333333],
        [-0.25,1,0.6666666667],[0.25,1,0.6666666667],[1,0.25,0.6666666667],[1,-0.25,0.6666666667],
        [0.25,-1,0.6666666667],[-0.25,-1,0.6666666667],[-1,-0.25,0.6666666667],[-1,0.25,0.6666666667],
        [-0.46,0.46,1],[0.46,0.46,1],[0.46,-0.46,1],[-0.46,-0.46,1],[0,0,1]
    ];
}

function lpac41Xyz() {
    return [
        [0.976131199,0.656268998,0],[0.932012275,0.216888632,0],[0.932012275,-0.224256492,0],[0.976131199,-0.665445734,0],
        [0.637871407,-0.841921431,0],[0.189314304,-0.841921431,0],[-0.202197030,-0.841921431,0],[-0.604782213,-0.797802507,0],
        [-0.976131199,-0.661783864,0],[-0.932012275,-0.224256492,0],[-0.932012275,0.220594621,0],[-0.976131199,0.661783864,0],
        [-0.604782213,0.794140636,0],[-0.202197030,0.838259561,0],[0.189314304,0.838259561,0],[0.637871407,0.838259561,0],
        [0.976131199,0.426453522,0.4559249631],[0.976131199,0,0.4559249631],[0.976131199,-0.441189242,0.4559249631],
        [0.437483253,-0.841921431,0.4559249631],[-0.090046724,-0.841921431,0.4559249631],[-0.446704108,-0.841921431,0.4559249631],
        [-0.976131199,-0.375010856,0.4559249631],[-0.976131199,0,0.4559249631],[-0.976131199,0.375010856,0.4559249631],
        [-0.446704108,0.838259561,0.4559249631],[-0.077208117,0.838259561,0.4559249631],[0.437483253,0.838259561,0.4559249631],
        [0.976131199,0.235286223,0.8529952812],[0.976131199,-0.235286223,0.8529952812],
        [0.191167299,-0.841921431,0.8529952812],[-0.213226761,-0.841921431,0.8529952812],
        [-0.999999537,-0.216888632,0.8529952812],[-0.999999537,0.154416235,0.8529952812],[-0.213226761,0.838259561,0.8529952812],
        [0.191167299,0.838259561,0.8529952812],
        [0.483455172,0.441189242,0.9081439365],[0.483455172,-0.441189242,0.9081439365],
        [-0.479793301,-0.441189242,0.9081439365],[-0.479793301,0.441189242,0.9081439365],[0,0,0.9081439365]
    ];
}

function srst25Xyz() {
    return [
        [1.442,2.498,0],[2.498,1.442,0],[2.885,0,0],[2.498,-1.442,0],
        [1.442,-2.498,0],[0,-2.885,0],[-1.442,-2.498,0],[-2.498,-1.442,0],
        [-2.885,0,0],[-2.498,1.442,0],[-1.442,2.498,0],[0,2.885,0],
        [1.763,1.763,1.559],[2.493,0,1.559],[1.763,-1.763,1.559],[0,-2.493,1.559],
        [-1.763,-1.763,1.559],[-2.493,0,1.559],[-1.763,1.763,1.559],[0,2.493,1.559],
        [1.152,0,2.671],[0,-1.152,2.671],[-1.152,0,2.671],[0,1.152,2.671],
        [0,0,2.941]
    ];
}

function dodecaAeds() {
    return [
        { az: -31.717474, el: 0, distance: 1 },
        { az: -90, el: -31.717474, distance: 1 },
        { az: -90, el: 31.717474, distance: 1 },
        { az: -148.282526, el: 0, distance: 1 },
        { az: 180, el: -58.282526, distance: 1 },
        { az: 180, el: 58.282526, distance: 1 },
        { az: 148.282526, el: 0, distance: 1 },
        { az: 90, el: -31.717474, distance: 1 },
        { az: 90, el: 31.717474, distance: 1 },
        { az: 31.717474, el: 0, distance: 1 },
        { az: 0, el: -58.282526, distance: 1 },
        { az: 0, el: 58.282526, distance: 1 }
    ];
}

function icosahedron20Aeds() {
    var out = aedsFromXyz(icosaFaceCenters());
    for (var i = 0; i < out.length; i++) out[i].distance = 1;
    return out;
}

function aedsFromXyz(points) {
    var out = [];
    for (var i = 0; i < points.length; i++) {
        var x = points[i][0];
        var y = points[i][1];
        var z = points[i][2];
        var h = Math.sqrt(x * x + y * y);
        var d = Math.sqrt(x * x + y * y + z * z);
        out.push({ az: wrapDeg(Math.atan2(y, x) * 180 / Math.PI), el: Math.atan2(z, h) * 180 / Math.PI, distance: d });
    }
    return out;
}

function aedsFromRoomXyz(points) {
    var out = [];
    for (var i = 0; i < points.length; i++) {
        var x = points[i][0];
        var y = points[i][1];
        var z = points[i][2];
        var h = Math.sqrt(x * x + y * y);
        var d = Math.sqrt(x * x + y * y + z * z);
        out.push({ az: wrapDeg(-Math.atan2(x, y) * 180 / Math.PI), el: Math.atan2(z, h) * 180 / Math.PI, distance: d });
    }
    return out;
}

function normalizeAedDistances(points) {
    for (var i = 0; i < points.length; i++) points[i].distance = 1;
    return points;
}

function elevatedRing(count, el, distance) {
    var out = [];
    var az = ring(count);
    for (var i = 0; i < az.length; i++) out.push({ az: az[i], el: el, distance: distance });
    return out;
}

function srstDomeAeds(includeZenith) {
    var out = [];
    var lower = [-30, -60, -90, -120, -150, 180, 150, 120, 90, 60, 30, 0];
    var middle = [-45, -90, -135, 180, 135, 90, 45, 0];
    var upper = [-90, 180, 90, 0];
    for (var i = 0; i < lower.length; i++) out.push({ az: lower[i], el: 0, distance: 1 });
    for (var m = 0; m < middle.length; m++) out.push({ az: middle[m], el: 32, distance: 1 });
    for (var u = 0; u < upper.length; u++) out.push({ az: upper[u], el: 66.6, distance: 1 });
    if (includeZenith) out.push({ az: 0, el: 90, distance: 1 });
    return out;
}

function heightCountForLayout(name) {
    var parts = String(name).split(".");
    return parts.length > 2 ? clampInt(parts[2], 0, 8) : (name === "quad+oh" ? 2 : 0);
}

function overheadAzimuths(count) {
    var az = [];
    if (count === 2) az = [-45, 45];
    else if (count === 4) az = [-45, -135, 135, 45];
    else if (count === 6) az = [-45, -90, -135, 135, 90, 45];
    else if (count === 8) az = [-30, -75, -120, -165, 165, 120, 75, 30];
    else az = ring(count);
    var out = [];
    for (var i = 0; i < az.length; i++) out.push({ az: az[i], el: count === 2 ? 60 : 55, distance: count === 2 ? 0.88 : 0.9 });
    return out;
}

function ring(count) {
    return ringFrom(-30, count);
}

function ringFrom(startAz, count) {
    var out = [];
    for (var i = 0; i < count; i++) out.push(wrapDeg(startAz - i * 360 / count));
    return out;
}

function drawLayoutEdges(m, projected) {
    var edges = buildLayoutEdges(projected);
    if (m.set_line_width) m.set_line_width(1);
    for (var i = 0; i < edges.length; i++) {
        var a = projected[edges[i][0] - 1];
        var b = projected[edges[i][1] - 1];
        if (!a || !b) continue;
        line(m, a.x, a.y, b.x, b.y, 0.34, 0.34, 0.34);
    }
}

function drawPolyhedronShell(m, cx, cy, r, name) {
    var vertices = name === "dodeca12" ? dodecaShellVertices() : icosaShellVertices();
    var edges = nearestVertexEdges(vertices);
    var projected = [];
    for (var i = 0; i < vertices.length; i++) {
        var p = norm3(vertices[i]);
        projected.push({ x: cx - p[1] * r, y: cy - p[0] * r });
    }
    if (m.set_line_width) m.set_line_width(1);
    for (var e = 0; e < edges.length; e++) {
        var a = projected[edges[e][0]];
        var b = projected[edges[e][1]];
        line(m, a.x, a.y, b.x, b.y, 0.34, 0.34, 0.34);
    }
}

function buildLayoutEdges(projected) {
    var edges = [];
    var seen = {};
    var bands = projectedBands(projected);
    for (var b = 0; b < bands.length; b++) {
        addBandEdges(edges, seen, bands[b], projected);
    }
    return edges;
}

function dodecaShellVertices() {
    var phi = 1.61803398875;
    var invPhi = 1 / phi;
    return [
        [1, 1, 1], [1, 1, -1], [1, -1, 1], [1, -1, -1],
        [-1, 1, 1], [-1, 1, -1], [-1, -1, 1], [-1, -1, -1],
        [0, invPhi, phi], [0, invPhi, -phi], [0, -invPhi, phi], [0, -invPhi, -phi],
        [invPhi, phi, 0], [invPhi, -phi, 0], [-invPhi, phi, 0], [-invPhi, -phi, 0],
        [phi, 0, invPhi], [phi, 0, -invPhi], [-phi, 0, invPhi], [-phi, 0, -invPhi]
    ];
}

function icosaShellVertices() {
    var phi = 1.61803398875;
    return [
        [0, 1, phi], [0, -1, phi], [0, 1, -phi], [0, -1, -phi],
        [1, phi, 0], [-1, phi, 0], [1, -phi, 0], [-1, -phi, 0],
        [phi, 0, 1], [-phi, 0, 1], [phi, 0, -1], [-phi, 0, -1]
    ];
}

function icosaFaceCenters() {
    var vertices = [];
    var raw = icosaShellVertices();
    for (var r = 0; r < raw.length; r++) vertices.push(norm3(raw[r]));

    var minD2 = 999999;
    for (var a = 0; a < vertices.length; a++) {
        for (var b = a + 1; b < vertices.length; b++) {
            var d2 = distSquared3(vertices[a], vertices[b]);
            if (d2 > 0.0001 && d2 < minD2) minD2 = d2;
        }
    }

    var maxD2 = minD2 * 1.08;
    var centers = [];
    for (var i = 0; i < vertices.length; i++) {
        for (var j = i + 1; j < vertices.length; j++) {
            if (distSquared3(vertices[i], vertices[j]) > maxD2) continue;
            for (var k = j + 1; k < vertices.length; k++) {
                if (distSquared3(vertices[i], vertices[k]) > maxD2) continue;
                if (distSquared3(vertices[j], vertices[k]) > maxD2) continue;
                centers.push(norm3([
                    vertices[i][0] + vertices[j][0] + vertices[k][0],
                    vertices[i][1] + vertices[j][1] + vertices[k][1],
                    vertices[i][2] + vertices[j][2] + vertices[k][2]
                ]));
            }
        }
    }
    centers.sort(compareXyzByElAz);
    return centers;
}

function compareXyzByElAz(a, b) {
    var ea = xyzElevation(a);
    var eb = xyzElevation(b);
    if (Math.abs(ea - eb) > 0.001) return ea - eb;
    return wrapDeg(Math.atan2(a[1], a[0]) * 180 / Math.PI) - wrapDeg(Math.atan2(b[1], b[0]) * 180 / Math.PI);
}

function xyzElevation(p) {
    var h = Math.sqrt(p[0] * p[0] + p[1] * p[1]);
    return Math.atan2(p[2], h) * 180 / Math.PI;
}

function distSquared3(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    return dx * dx + dy * dy + dz * dz;
}

function nearestVertexEdges(vertices) {
    var edges = [];
    var minD2 = 999999;
    for (var a = 0; a < vertices.length; a++) {
        for (var b = a + 1; b < vertices.length; b++) {
            var d = dist3(norm3(vertices[a]), norm3(vertices[b]));
            var d2 = d * d;
            if (d2 > 0.0001 && d2 < minD2) minD2 = d2;
        }
    }
    var maxD2 = minD2 * 1.08;
    for (var i = 0; i < vertices.length; i++) {
        for (var j = i + 1; j < vertices.length; j++) {
            var dist = dist3(norm3(vertices[i]), norm3(vertices[j]));
            if (dist * dist <= maxD2) edges.push([i, j]);
        }
    }
    return edges;
}

function triangulatedSurfaceEdges(projected) {
    var edges = [];
    var seen = {};
    var bands = projectedBands(projected);
    var stable = stableProjectedPoints(projected);
    for (var b = 0; b < bands.length; b++) {
        var split = splitBandPoints(bands[b]);
        if (split.perimeter.length > 1) {
            for (var p = 0; p < split.perimeter.length; p++) {
                addEdgeIfClear(edges, seen, split.perimeter[p].id, split.perimeter[(p + 1) % split.perimeter.length].id, stable);
            }
        }
        for (var c = 0; c < split.centers.length; c++) {
            var centerBracket = lowerBracketPoints(split.centers[c], split.perimeter);
            for (var k = 0; k < centerBracket.length; k++) addEdgeIfClear(edges, seen, split.centers[c].id, centerBracket[k].id, stable);
        }
    }
    for (var i = 0; i + 1 < bands.length; i++) {
        var lower = splitBandPoints(bands[i]).perimeter;
        var upperSplit = splitBandPoints(bands[i + 1]);
        var upper = upperSplit.perimeter.concat(upperSplit.centers);
        if (!lower.length || !upper.length) continue;
        for (var u = 0; u < upper.length; u++) {
            var bracket = lowerBracketPoints(upper[u], lower);
            for (var j = 0; j < bracket.length; j++) addEdgeIfClear(edges, seen, upper[u].id, bracket[j].id, stable);
        }
    }
    return edges;
}

function splitBandPoints(band) {
    var pts = band.points.slice(0);
    pts.sort(function(a, b) { return azKey(a.speaker.az) - azKey(b.speaker.az); });
    var perimeter = [];
    var centers = [];
    for (var i = 0; i < pts.length; i++) {
        var az = wrapDeg(pts[i].speaker.az);
        if (pts.length > 4 && Math.abs(az) < 1.0) centers.push(pts[i]);
        else perimeter.push(pts[i]);
    }
    return { perimeter: perimeter, centers: centers };
}

function stableProjectedPoints(projected) {
    var stable = [];
    for (var i = 0; i < projected.length; i++) {
        var s = projected[i].speaker;
        var p = pointFromAzElDistance(s.az, s.el, s.distance);
        stable.push({ id: projected[i].id, speaker: s, x: p[0], y: p[1] });
    }
    return stable;
}

function lowerBracketPoints(upper, lower) {
    if (lower.length < 1) return [];
    if (lower.length == 1) return [lower[0]];
    var sorted = lower.slice(0);
    sorted.sort(function(a, b) { return azKey(a.speaker.az) - azKey(b.speaker.az); });
    var upperAz = azKey(upper.speaker.az);
    for (var i = 0; i < sorted.length; i++) {
        if (Math.abs(azKey(sorted[i].speaker.az) - upperAz) < 0.01) {
            return [sorted[positiveModulo(i - 1, sorted.length)], sorted[i], sorted[(i + 1) % sorted.length]];
        }
    }
    for (var j = 0; j < sorted.length; j++) {
        var a = sorted[j];
        var b = sorted[(j + 1) % sorted.length];
        var aAz = azKey(a.speaker.az);
        var bAz = azKey(b.speaker.az);
        if (bAz < aAz) bAz += 360;
        var testAz = upperAz < aAz ? upperAz + 360 : upperAz;
        if (testAz > aAz && testAz < bAz) return [a, b];
    }
    return [sorted[0], sorted[1]];
}

function surroundSurfaceEdges(name, count) {
    var edges = [];
    var seen = {};
    var parts = normalizeLayoutName(name).split(".");
    var bed = intOr(parts[0], 0);
    var height = parts.length > 2 ? intOr(parts[2], 0) : 0;
    addSurroundBedEdges(edges, seen, bed);
    addSurroundHeightEdges(edges, seen, bed, height);
    var filtered = [];
    for (var i = 0; i < edges.length; i++) {
        if (edges[i][0] <= count && edges[i][1] <= count) filtered.push(edges[i]);
    }
    return filtered;
}

function isSurroundLayout(name) {
    name = normalizeLayoutName(name);
    return name === "5.0" || name === "6.0" || name === "7.0" || name === "9.0"
        || name === "5.0.2" || name === "7.0.2" || name === "9.0.2"
        || name === "5.0.4" || name === "7.0.4" || name === "9.0.4"
        || name === "7.0.6" || name === "9.0.6" || name === "11.0.8";
}

function addSurroundBedEdges(edges, seen, bed) {
    if (bed === 5) {
        addClosedPathEdges(edges, seen, [1, 2, 3, 4]);
        addUniqueEdge(edges, seen, 5, 1);
        addUniqueEdge(edges, seen, 5, 4);
    } else if (bed === 6) {
        addClosedPathEdges(edges, seen, [5, 1, 2, 3, 4]);
        addUniqueEdge(edges, seen, 6, 1);
        addUniqueEdge(edges, seen, 6, 5);
    } else if (bed === 7) {
        addClosedPathEdges(edges, seen, [6, 1, 2, 3, 4, 5]);
        addUniqueEdge(edges, seen, 7, 1);
        addUniqueEdge(edges, seen, 7, 6);
    } else if (bed === 9) {
        addClosedPathEdges(edges, seen, [8, 1, 2, 3, 4, 5, 6, 7]);
        addUniqueEdge(edges, seen, 9, 1);
        addUniqueEdge(edges, seen, 9, 8);
    } else if (bed === 11) {
        addClosedPathEdges(edges, seen, [10, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
        addUniqueEdge(edges, seen, 11, 1);
        addUniqueEdge(edges, seen, 11, 10);
    }
}

function addSurroundHeightEdges(edges, seen, bed, height) {
    if (height <= 0) return;
    var top = [];
    for (var i = 0; i < height; i++) top.push(bed + i + 1);
    addClosedPathEdges(edges, seen, top);
    var patches = surroundHeightAnchors(bed, height);
    for (var h = 0; h < Math.min(top.length, patches.length); h++) {
        for (var a = 0; a < patches[h].length; a++) addUniqueEdge(edges, seen, top[h], patches[h][a]);
    }
}

function surroundHeightAnchors(bed, height) {
    if (bed === 5 && height === 2) return [[1, 2], [3, 4]];
    if (bed === 7 && height === 2) return [[2, 3], [4, 5]];
    if (bed === 9 && height === 2) return [[3, 4], [5, 6]];
    if (bed === 5 && height === 4) return [[1, 2], [2, 3], [3, 4], [4, 1]];
    if (bed === 7 && height === 4) return [[6, 1], [2, 3], [4, 5], [5, 6]];
    if (bed === 9 && height === 4) return [[8, 1, 2], [3, 4], [5, 6], [7, 8]];
    if (bed === 7 && height === 6) return [[6, 1], [1, 2], [2, 3], [4, 5], [5, 6], [6, 1]];
    if (bed === 9 && height === 6) return [[8, 1, 2], [2, 3], [3, 4], [5, 6], [6, 7], [7, 8]];
    if (bed === 11 && height === 8) return [[10, 1, 2], [2, 3], [3, 4], [4, 5], [7, 8], [8, 9], [9, 10], [10, 1]];
    return [];
}

function projectedBands(projected) {
    var bands = [];
    for (var i = 0; i < projected.length; i++) {
        var s = projected[i].speaker;
        var placed = 0;
        for (var b = 0; b < bands.length; b++) {
            if (Math.abs(bands[b].el - s.el) < 8) {
                bands[b].points.push(projected[i]);
                placed = 1;
                break;
            }
        }
        if (!placed) bands.push({ el: s.el, points: [projected[i]] });
    }
    bands.sort(function(a, b) { return a.el - b.el; });
    for (var j = 0; j < bands.length; j++) {
        bands[j].points.sort(function(a, b) { return azKey(a.speaker.az) - azKey(b.speaker.az); });
    }
    return bands;
}

function addBandEdges(edges, seen, band, projected) {
    var pts = band.points;
    if (pts.length < 2) return;
    for (var i = 0; i < pts.length; i++) {
        addEdgeIfClear(edges, seen, pts[i].id, pts[(i + 1) % pts.length].id, projected);
    }
}

function addTierEdges(edges, seen, lowerBand, upperBand, projected) {
    var lower = lowerBand.points;
    var upper = upperBand.points;
    if (!lower.length || !upper.length) return;
    if (upper.length === 1) {
        for (var a = 0; a < lower.length; a++) addEdgeIfClear(edges, seen, upper[0].id, lower[a].id, projected);
        return;
    }
    for (var i = 0; i < upper.length; i++) {
        var nearLower = nearestByAz(upper[i], lower);
        addEdgeIfClear(edges, seen, upper[i].id, nearLower.id, projected);
    }
    for (var j = 0; j < lower.length; j++) {
        var nearUpper = nearestByAz(lower[j], upper);
        addEdgeIfClear(edges, seen, lower[j].id, nearUpper.id, projected);
    }
}

function nearestByAz(point, candidates) {
    var best = candidates[0];
    var bestD = 9999;
    for (var i = 0; i < candidates.length; i++) {
        var d = azDistance(point.speaker.az, candidates[i].speaker.az);
        if (d < bestD) {
            bestD = d;
            best = candidates[i];
        }
    }
    return best;
}

function addEdgeIfClear(edges, seen, a, b, projected) {
    if (a === b) return;
    var key = edgeKey(a, b);
    if (seen[key]) return;
    var pa = projected[a - 1];
    var pb = projected[b - 1];
    if (!pa || !pb) return;
    if (Math.abs(pa.x - pb.x) < 0.5 && Math.abs(pa.y - pb.y) < 0.5) return;
    for (var i = 0; i < edges.length; i++) {
        var ea = edges[i][0];
        var eb = edges[i][1];
        if (ea === a || ea === b || eb === a || eb === b) continue;
        if (segmentsIntersect(pa, pb, projected[ea - 1], projected[eb - 1])) return;
    }
    seen[key] = 1;
    edges.push([a, b]);
}

function segmentsIntersect(a, b, c, d) {
    if (!a || !b || !c || !d) return false;
    var o1 = orient(a, b, c);
    var o2 = orient(a, b, d);
    var o3 = orient(c, d, a);
    var o4 = orient(c, d, b);
    return o1 * o2 < -0.000001 && o3 * o4 < -0.000001;
}

function orient(a, b, c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

function edgeKey(a, b) {
    return Math.min(a, b) + ":" + Math.max(a, b);
}

function addClosedPathEdges(edges, seen, ids) {
    for (var i = 0; i < ids.length; i++) addUniqueEdge(edges, seen, ids[i], ids[(i + 1) % ids.length]);
}

function addUniqueEdge(edges, seen, a, b) {
    if (a === b) return;
    var key = edgeKey(a, b);
    if (seen[key]) return;
    seen[key] = 1;
    edges.push([a, b]);
}

function azKey(az) {
    var key = Number(az);
    return key < 0 ? key + 360 : key;
}

function positiveModulo(value, length) {
    return ((value % length) + length) % length;
}

function azDistance(a, b) {
    var d = Math.abs(azKey(a) - azKey(b));
    return Math.min(d, 360 - d);
}

function layoutCounts(name) {
    name = normalizeLayoutName(name);
    if (name === "5.0") return { high: 5 };
    if (name === "6.0") return { high: 6 };
    if (name === "7.0") return { high: 7 };
    if (name === "5.0.2") return { high: 7 };
    if (name === "7.0.2") return { high: 9 };
    if (name === "5.0.4") return { high: 9 };
    if (name === "7.0.4") return { high: 11 };
    if (name === "7.0.6") return { high: 13 };
    if (name === "9.0") return { high: 9 };
    if (name === "9.0.2") return { high: 11 };
    if (name === "9.0.4") return { high: 13 };
    if (name === "9.0.6") return { high: 15 };
    if (name === "11.0.8") return { high: 19 };
    if (name === "quad") return { high: 4 };
    if (name === "quad+oh") return { high: 6 };
    if (name === "cube8" || name === "octo") return { high: 8 };
    if (name === "ring12" || name === "dodeca12") return { high: 12 };
    if (name === "icosahedron20") return { high: 20 };
    if (name === "ring16" || name === "double16") return { high: 16 };
    if (name === "cube17") return { high: 17 };
    if (name === "double20") return { high: 20 };
    if (name === "dome24") return { high: 24 };
    if (name === "dome25" || name === "srst25") return { high: 25 };
    if (name === "cube41" || name === "lpac41") return { high: 41 };
    return { high: 0 };
}

function normalizeLayoutName(v) {
    var n = String(v || "quad").toLowerCase();
    if (n === "7.0.4.") return "7.0.4";
    if (n === "icosa20" || n === "ico20") return "icosahedron20";
    return n;
}

function layoutNameForIndex(i) {
    var names = ["custom", "cube8", "cube17", "dodeca12", "dome24", "dome25", "double16", "double20", "octo", "quad", "quad+oh", "ring12", "ring16", "5.0", "6.0", "7.0", "5.0.2", "7.0.2", "5.0.4", "7.0.4", "9.0", "9.0.2", "9.0.4", "9.0.6", "7.0.6", "11.0.8", "icosahedron20", "cube41", "lpac41", "srst25"];
    return names[Math.max(0, Math.min(names.length - 1, i))];
}

function layoutIndexForName(name) {
    for (var i = 0; i < 30; i++) if (layoutNameForIndex(i) === name) return i;
    return 9;
}

function topViewPoint(cx, cy, r, speaker) {
    var p = pointFromAzElDistance(speaker.az, speaker.el || 0, speaker.distance || 1);
    return { x: cx - p[1] * r, y: cy - p[0] * r };
}

function pointFromAzElDistance(az, el, distance) {
    var azr = Number(az) * Math.PI / 180;
    var elr = Number(el) * Math.PI / 180;
    var c = Math.cos(elr);
    var d = Math.max(0.1, Number(distance));
    return [Math.cos(azr) * c * d, Math.sin(azr) * c * d, Math.sin(elr) * d];
}

function norm3(p) {
    var d = Math.sqrt(p[0] * p[0] + p[1] * p[1] + p[2] * p[2]);
    if (d < 0.000001) return [0, 0, 0];
    return [p[0] / d, p[1] / d, p[2] / d];
}

function dist3(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    return Math.sqrt(dx * dx + dy * dy + dz * dz);
}

function square(m, x, y, s, r, g, b, sr, sg, sb) {
    m.set_source_rgb(r, g, b);
    m.rectangle(x - s * 0.5, y - s * 0.5, s, s);
    m.fill();
    strokeRect(m, x - s * 0.5, y - s * 0.5, s, s, sr, sg, sb);
}

function strokeRect(m, x, y, w, h, r, g, b) {
    m.set_source_rgb(r, g, b);
    m.rectangle(x, y, w, h);
    m.stroke();
}

function strokeCircle(m, x, y, r, cr, cg, cb) {
    m.set_source_rgb(cr, cg, cb);
    m.ellipse(x - r, y - r, r * 2, r * 2);
    m.stroke();
}

function line(m, x1, y1, x2, y2, r, g, b) {
    m.set_source_rgb(r, g, b);
    m.move_to(x1, y1);
    m.line_to(x2, y2);
    m.stroke();
}

function text(m, s, x, y, r, g, b, size) {
    m.select_font_face("Menlo");
    m.set_font_size(size || 10);
    m.set_source_rgb(r, g, b);
    m.move_to(x, y);
    m.show_text(String(s));
}

function clamp(v, lo, hi) { return Math.max(lo, Math.min(hi, Number(v))); }
function clampInt(v, lo, hi) { return Math.round(clamp(v, lo, hi)); }
function intOr(value, fallback) { var n = parseInt(value, 10); return isNaN(n) ? fallback : n; }
function signed(v) { return (v >= 0 ? "+" : "") + Number(v).toFixed(1); }
function wrapDeg(v) {
    while (v <= -180) v += 360;
    while (v > 180) v -= 360;
    return v;
}
