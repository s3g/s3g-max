autowatch = 1;
inlets = 1;
outlets = 0;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var inputCount = 16;
var outputCount = 24;
var order = 3;
var activeSpeakers = 24;
var layoutName = "sphere24";
var speakers = [];
for (var i = 0; i < 64; i++) speakers.push({ id: i + 1, az: 0, el: 0, distance: 1, gain: 1 });
seedLayout(layoutName);

var viewYaw = -90 * Math.PI / 180;
var viewPitch = 90 * Math.PI / 180;
var viewZoom = 1;
var dragX = 0;
var dragY = 0;
var dragging = 0;
var redrawPending = 0;
var redrawTask = new Task(doRedraw, this);
var MIN_VIEW_PITCH = 8 * Math.PI / 180;
var MAX_VIEW_PITCH = 90 * Math.PI / 180;
var MIN_VIEW_ZOOM = 0.45;
var MAX_VIEW_ZOOM = 2.5;

function config(inputs, outputs, orderValue, activeValue) {
    inputCount = clampInt(inputs, 1, 64);
    outputCount = clampInt(outputs, 2, 64);
    order = clampInt(orderValue, 1, 7);
    activeSpeakers = clampInt(activeValue, 2, outputCount);
    refresh();
}

function layout(indexOrName, maybeName) {
    layoutName = normalizeLayoutName(maybeName || indexOrName || layoutName);
    seedLayout(layoutName);
    refresh();
}

function speaker(index, az, el, distance, gain) {
    var i = clampInt(index, 1, 64) - 1;
    speakers[i] = {
        id: i + 1,
        az: Number(az),
        el: Number(el),
        distance: Math.max(0.1, Number(distance)),
        gain: isFinite(Number(gain)) ? Number(gain) : 1
    };
    refresh();
}

function done() { refresh(); }
function bang() { refresh(); }
function active(v) { refresh(); }
function zoom(v) {
    viewZoom = clamp(Number(v), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function zoomin(v) {
    var step = isFinite(Number(v)) ? Number(v) : 0.15;
    viewZoom = clamp(viewZoom + Math.abs(step), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function zoomout(v) {
    var step = isFinite(Number(v)) ? Number(v) : 0.15;
    viewZoom = clamp(viewZoom - Math.abs(step), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function view(name) {
    var s = String(name || "top").toLowerCase();
    if (s == "top") {
        viewYaw = -90 * Math.PI / 180;
        viewPitch = 90 * Math.PI / 180;
    } else if (s == "side" || s == "right") {
        viewYaw = 0;
        viewPitch = 8 * Math.PI / 180;
    } else if (s == "left") {
        viewYaw = 180 * Math.PI / 180;
        viewPitch = 8 * Math.PI / 180;
    } else if (s == "front") {
        viewYaw = -90 * Math.PI / 180;
        viewPitch = 8 * Math.PI / 180;
    } else if (s == "back") {
        viewYaw = 90 * Math.PI / 180;
        viewPitch = 8 * Math.PI / 180;
    } else if (s == "iso" || s == "3/4" || s == "threequarter") {
        viewYaw = -28 * Math.PI / 180;
        viewPitch = 38 * Math.PI / 180;
    }
    refresh();
}

function anything() {
    var a = arrayfromargs(messagename, arguments);
    if (a[0] === "config") config(a[1], a[2], a[3], a[4]);
    else if (a[0] === "layout") layout(a[1], a[2]);
    else if (a[0] === "speaker") speaker(a[1], a[2], a[3], a[4], a[5]);
    else if (a[0] === "view") view(a[1]);
    else if (a[0] === "zoom") zoom(a[1]);
    else if (a[0] === "zoomin") zoomin(a[1]);
    else if (a[0] === "zoomout") zoomout(a[1]);
}

function paint() {
    var w = box.rect[2] - box.rect[0];
    var h = box.rect[3] - box.rect[1];
    background(w, h);
    drawField(w, h);
}

function background(w, h) {
    set(0.055, 0.06, 0.067, 1);
    mgraphics.rectangle(0, 0, w, h);
    mgraphics.fill();
}

function drawField(w, h) {
    var cx = w * 0.5;
    var cy = h * 0.54;
    var radius = Math.min(w, h) * 0.35;
    var projected = projectSpeakers(cx, cy, radius);
    projected.sort(function(a, b) { return b.z - a.z; });
    drawPolyhedronShell(cx, cy, radius);
    drawTierEdges(projected);
    drawSpeakers(projected);
    drawLabels(projected);
}

function projectSpeakers(cx, cy, radius) {
    var out = [];
    for (var i = 0; i < activeSpeakers; i++) {
        var sp = speakers[i] || fallbackSpeaker(i, activeSpeakers);
        var p = pointFromAzElDistance(sp.az, sp.el, sp.distance);
        var rp = rotatePoint(p);
        out.push({
            id: i + 1,
            az: sp.az,
            el: sp.el,
            p: p,
            r: rp,
            x: cx + rp[0] * radius * viewZoom,
            y: cy - rp[1] * radius * viewZoom,
            z: rp[2]
        });
    }
    return out;
}

function drawDistancePlane(cx, cy, radius) {
    var r = radius * viewZoom;
    var pts = planePoints(cx, cy, r);
    if (pts.length < 3) return;
    set(0.44, 0.44, 0.44, 0.045);
    drawPointPath(pts);
    mgraphics.fill();
    strokedPointPath(pts, 0.58, 0.58, 0.58, 0.17);
    strokedPointPath(planePoints(cx, cy, r * 0.66), 0.58, 0.58, 0.58, 0.12);
    strokedPointPath(planePoints(cx, cy, r * 0.33), 0.58, 0.58, 0.58, 0.09);
}

function drawDomeShell(cx, cy, radius) {
    strokedPointPath(planePoints(cx, cy, radius * viewZoom), 0.34, 0.34, 0.34, 0.42);
}

function drawTierEdges(projected) {
    if (layoutKey() == "dodeca12" || layoutKey() == "icosahedron20") return;
    if (layoutKey() == "quad+oh") {
        drawTier(filterIds(projected, [1, 2, 3, 4]));
        drawTier(filterIds(projected, [5, 6]));
        return;
    }
    if (layoutKey() == "cube8") {
        drawTier(filterIds(projected, [1, 2, 3, 4]));
        drawTier(filterIds(projected, [5, 6, 7, 8]));
        return;
    }
    if (layoutKey() == "cube17") {
        drawTier(filterIds(projected, [1, 2, 3, 4]));
        drawTier(filterIds(projected, [5, 6, 7, 8, 9, 10, 11, 12]));
        drawTier(filterIds(projected, [13, 14, 15, 16]));
        return;
    }
    var tiers = speakerTiers(projected);
    for (var i = 0; i < tiers.length; i++) drawTier(tiers[i]);
}

function drawTier(row) {
    if (row.length < 2) return;
    row.sort(function(a, b) { return Math.atan2(a.p[1], a.p[0]) - Math.atan2(b.p[1], b.p[0]); });
    if (row.length == 2) {
        line(row[0].x, row[0].y, row[1].x, row[1].y, 0.42, 0.42, 0.42, 0.55);
        return;
    }
    for (var i = 0; i < row.length; i++) {
        var a = row[i];
        var b = row[(i + 1) % row.length];
        line(a.x, a.y, b.x, b.y, 0.42, 0.42, 0.42, 0.52);
    }
}

function drawPolyhedronShell(cx, cy, radius) {
    var key = layoutKey();
    if (key != "dodeca12" && key != "icosahedron20") return;
    var verts = key == "dodeca12" ? dodecaShellVertices() : icosaShellVertices();
    var edges = nearestVertexEdges(verts);
    var projected = [];
    for (var i = 0; i < verts.length; i++) {
        var p = norm3(verts[i]);
        var rp = rotatePoint(p);
        projected.push({ x: cx + rp[0] * radius * viewZoom, y: cy - rp[1] * radius * viewZoom, z: rp[2] });
    }
    for (var e = 0; e < edges.length; e++) {
        var a = projected[edges[e][0]];
        var b = projected[edges[e][1]];
        var front = depthFront((a.z + b.z) * 0.5);
        line(a.x, a.y, b.x, b.y, 0.56, 0.56, 0.56, 0.08 + 0.18 * front);
    }
}

function drawSpeakers(projected) {
    for (var i = 0; i < projected.length; i++) {
        var p = projected[i];
        var depth = clamp((p.z + 1) * 0.5, 0, 1);
        var c = 0.36 + depth * 0.34;
        square(p.x, p.y, 8, c, c, c, 0.88, 0.88, 0.88, 0.65);
    }
}

function drawLabels(projected) {
    var used = [];
    for (var i = 0; i < projected.length; i++) used[i] = 0;
    for (var p = 0; p < projected.length; p++) {
        if (used[p]) continue;
        used[p] = 1;
        var label = String(projected[p].id);
        for (var q = p + 1; q < projected.length; q++) {
            if (used[q]) continue;
            if (Math.abs(projected[p].x - projected[q].x) > 1.5 || Math.abs(projected[p].y - projected[q].y) > 1.5) continue;
            used[q] = 1;
            label += "/" + projected[q].id;
        }
        text(label, projected[p].x + 7, projected[p].y + 4, 0.68, 0.68, 0.68, 8);
    }
}

function fallbackSpeaker(i, n) {
    return { id: i + 1, az: -30 - i * 360 / Math.max(1, n), el: 0, distance: 1, gain: 1 };
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

function seedLayout(name) {
    var key = normalizeLayoutName(name);
    clearSpeakers();
    if (key == "quad") {
        activeSpeakers = 4;
        setSeed(0, 45, 0, 1);
        setSeed(1, -45, 0, 1);
        setSeed(2, -135, 0, 1);
        setSeed(3, 135, 0, 1);
    } else if (key == "quad+oh") {
        activeSpeakers = 6;
        setSeed(0, 45, 0, 1);
        setSeed(1, -45, 0, 1);
        setSeed(2, -135, 0, 1);
        setSeed(3, 135, 0, 1);
        setSeed(4, 90, 60, 1);
        setSeed(5, -90, 60, 1);
    } else if (key == "cube8") {
        activeSpeakers = 8;
        seedXyz([[1,-1,-1],[-1,-1,-1],[-1,1,-1],[1,1,-1],[1,-1,1],[-1,-1,1],[-1,1,1],[1,1,1]]);
    } else if (key == "cube17") {
        activeSpeakers = 17;
        seedXyz([[1,-1,-1],[-1,-1,-1],[-1,1,-1],[1,1,-1],[1,-1,0],[0,-1,0],[-1,-1,0],[-1,0,0],[-1,1,0],[0,1,0],[1,1,0],[1,0,0],[1,-1,1],[-1,-1,1],[-1,1,1],[1,1,1],[0,0,1]]);
    } else if (key == "cube41") {
        activeSpeakers = 41;
        seedXyz(cube41Xyz());
    } else if (key == "lpac41") {
        activeSpeakers = 41;
        seedXyz(lpac41Xyz());
    } else if (key == "dome24") {
        activeSpeakers = 24;
        seedSrstDome(0);
    } else if (key == "dome25") {
        activeSpeakers = 25;
        seedSrstDome(1);
    } else if (key == "srst25") {
        activeSpeakers = 25;
        seedRoomXyz(srst25Xyz());
        for (var s25 = 0; s25 < activeSpeakers; s25++) speakers[s25].distance = 1;
    } else if (key == "octo") {
        activeSpeakers = 8;
        seedRing(0, 8, -45, 0);
    } else if (key == "dodeca12") {
        activeSpeakers = 12;
        seedDodeca12();
    } else if (key == "icosahedron20") {
        activeSpeakers = 20;
        seedIcosahedron20();
    } else if (key == "sphere24") {
        activeSpeakers = 24;
        seedXyz([
            [0.285652275,0,0.958333333],[-0.356977173,0.327020333,0.875],[0.053413032,-0.608613947,0.791666667],[0.429483666,0.560185389,0.708333333],
            [-0.768691718,-0.135970741,0.625],[0.709255111,-0.451170045,0.541666667],[-0.230731212,0.858308606,0.458333333],[-0.427272247,-0.822686712,0.375],
            [0.898479629,0.328123319,0.291666667],[-0.904063458,0.373184253,0.208333333],[0.420521661,-0.898630365,0.125],[0.299023957,0.953335493,0.041666667],
            [-0.864459832,-0.500972143,-0.041666667],[0.969015453,-0.213035329,-0.125],[-0.562509872,0.800112409,-0.208333333],[-0.122923048,-0.948588678,-0.291666667],
            [0.70884859,0.597418342,-0.375],[-0.888021405,0.036722473,-0.458333333],[0.59583731,-0.592937705,-0.541666667],[-0.036058186,0.779791515,-0.625],
            [-0.452262552,-0.541961689,-0.708333333],[0.605497091,0.081468777,-0.791666667],[-0.397396334,0.276498018,-0.875],[0.062695352,-0.278687127,-0.958333333]
        ]);
    }
}

function seedSrstDome(includeZenith) {
    var lower = [-30, -60, -90, -120, -150, 180, 150, 120, 90, 60, 30, 0];
    var middle = [-45, -90, -135, 180, 135, 90, 45, 0];
    var upper = [-90, 180, 90, 0];
    for (var i = 0; i < lower.length; i++) setSeed(i, lower[i], 0, 1);
    for (var m = 0; m < middle.length; m++) setSeed(12 + m, middle[m], 32, 1);
    for (var u = 0; u < upper.length; u++) setSeed(20 + u, upper[u], 66.6, 1);
    if (includeZenith) setSeed(24, 0, 90, 1);
}

function seedDodeca12() {
    var pts = [
        [-31.717474, 0], [-90, -31.717474], [-90, 31.717474], [-148.282526, 0],
        [180, -58.282526], [180, 58.282526], [148.282526, 0], [90, -31.717474],
        [90, 31.717474], [31.717474, 0], [0, -58.282526], [0, 58.282526]
    ];
    for (var i = 0; i < pts.length; i++) setSeed(i, pts[i][0], pts[i][1], 1);
}

function seedIcosahedron20() {
    var centers = icosaFaceCenters();
    centers.sort(function(a, b) {
        var ea = vecElevationDeg(a);
        var eb = vecElevationDeg(b);
        if (Math.abs(ea - eb) > 0.001) return ea - eb;
        return wrapSignedDeg(vecAzimuthDeg(a)) - wrapSignedDeg(vecAzimuthDeg(b));
    });
    for (var i = 0; i < Math.min(20, centers.length); i++) {
        setSeed(i, vecAzimuthDeg(centers[i]), vecElevationDeg(centers[i]), 1);
    }
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

function nearestVertexEdges(vertices) {
    var minD2 = 999999;
    var normalized = [];
    for (var i = 0; i < vertices.length; i++) normalized.push(norm3(vertices[i]));
    for (var a = 0; a < normalized.length; a++) {
        for (var b = a + 1; b < normalized.length; b++) {
            var d2 = distSquared3(normalized[a], normalized[b]);
            if (d2 > 0.0001 && d2 < minD2) minD2 = d2;
        }
    }
    var maxD2 = minD2 * 1.08;
    var edges = [];
    for (var ia = 0; ia < normalized.length; ia++) {
        for (var ib = ia + 1; ib < normalized.length; ib++) {
            if (distSquared3(normalized[ia], normalized[ib]) <= maxD2) edges.push([ia, ib]);
        }
    }
    return edges;
}

function clearSpeakers() {
    for (var i = 0; i < 64; i++) speakers[i] = { id: i + 1, az: 0, el: 0, distance: 1, gain: 1 };
}

function setSeed(i, az, el, distance) {
    speakers[i] = { id: i + 1, az: wrapSignedDeg(az), el: Number(el), distance: Math.max(0.1, Number(distance)), gain: 1 };
}

function seedRing(base, count, rightAzimuthDeg, elevationDeg) {
    var step = 360 / Math.max(1, count);
    for (var i = 0; i < count; i++) setSeed(base + i, rightAzimuthDeg - step * i, elevationDeg, 1);
}

function seedXyz(points) {
    for (var i = 0; i < points.length; i++) {
        var p = points[i];
        var r = Math.sqrt(Math.max(0.000001, p[0] * p[0] + p[1] * p[1] + p[2] * p[2]));
        setSeed(i, Math.atan2(p[1], p[0]) * 180 / Math.PI, Math.asin(clamp(p[2] / r, -1, 1)) * 180 / Math.PI, Math.max(0.15, r));
    }
}

function seedRoomXyz(points) {
    for (var i = 0; i < points.length; i++) {
        var p = points[i];
        var r = Math.sqrt(Math.max(0.000001, p[0] * p[0] + p[1] * p[1] + p[2] * p[2]));
        setSeed(i, -Math.atan2(p[0], p[1]) * 180 / Math.PI, Math.asin(clamp(p[2] / r, -1, 1)) * 180 / Math.PI, Math.max(0.15, r));
    }
}

function speakerTiers(projected) {
    var tiers = [];
    for (var i = 0; i < projected.length; i++) {
        var placed = 0;
        for (var t = 0; t < tiers.length; t++) {
            if (Math.abs(tiers[t][0].el - projected[i].el) < 8) {
                tiers[t].push(projected[i]);
                placed = 1;
                break;
            }
        }
        if (!placed) tiers.push([projected[i]]);
    }
    tiers.sort(function(a, b) { return a[0].el - b[0].el; });
    return tiers;
}

function filterIds(projected, ids) {
    var out = [];
    for (var i = 0; i < ids.length; i++) {
        for (var j = 0; j < projected.length; j++) {
            if (projected[j].id == ids[i]) {
                out.push(projected[j]);
                break;
            }
        }
    }
    return out;
}

function layoutKey() {
    return normalizeLayoutName(layoutName);
}

function normalizeLayoutName(name) {
    if (typeof name == "number") return layoutNameFromNumber(name);
    var s = String(name || "").toLowerCase();
    if (/^-?\d+(\.\d+)?$/.test(s)) return layoutNameFromNumber(Number(s));
    if (s == "6" || s == "quad overhead" || s == "quadoverhead6") return "quad+oh";
    if (s == "8" || s == "octophonicring" || s == "octo ring" || s == "octo-ring" || s == "octoring") return "octo";
    if (s == "dodeca" || s == "dodecahedron12") return "dodeca12";
    if (s == "icosa" || s == "icosa20" || s == "icosahedron") return "icosahedron20";
    if (s == "cube41") return "cube41";
    if (s == "lpac41") return "lpac41";
    if (s == "srst25") return "srst25";
    return s;
}

function layoutNameFromNumber(value) {
    var i = Math.round(Number(value));
    if (i == 0) return "custom";
    if (i == 1) return "quad";
    if (i == 2) return "cube8";
    if (i == 3) return "cube17";
    if (i == 4) return "dome24";
    if (i == 5) return "dome25";
    if (i == 6) return "quad+oh";
    if (i == 7) return "sphere24";
    if (i == 8) return "dodeca12";
    if (i == 9) return "icosahedron20";
    if (i == 10) return "octo";
    if (i == 11) return "cube41";
    if (i == 12) return "lpac41";
    if (i == 13) return "srst25";
    return "sphere24";
}

function onclick(x, y) {
    dragging = 1;
    dragX = x;
    dragY = y;
}

function ondrag(x, y, button) {
    if (!dragging && button) dragging = 1;
    if (dragging) {
        viewYaw += (x - dragX) * 0.012;
        viewPitch += (y - dragY) * 0.012;
        viewPitch = clamp(viewPitch, MIN_VIEW_PITCH, MAX_VIEW_PITCH);
        dragX = x;
        dragY = y;
        refresh();
    }
    if (!button) dragging = 0;
}

function onidleout() {
    dragging = 0;
}

function wheel(x, y, delta) {
    viewZoom = clamp(viewZoom + Number(delta) * 0.08, MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function msg_float(v) {
    viewZoom = clamp(Number(v), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function planePoints(cx, cy, radius) {
    var pts = [];
    for (var i = 0; i < 64; i++) {
        var a = i * Math.PI * 2 / 64;
        var p = rotatePoint([Math.cos(a), Math.sin(a), 0]);
        pts.push({ x: cx + p[0] * radius, y: cy - p[1] * radius });
    }
    return pts;
}

function pointFromAzEl(az, el) {
    var azr = Number(az) * Math.PI / 180;
    var elr = Number(el) * Math.PI / 180;
    var c = Math.cos(elr);
    return norm3([Math.cos(azr) * c, Math.sin(azr) * c, Math.sin(elr)]);
}

function pointFromAzElDistance(az, el, distance) {
    return scalePoint(pointFromAzEl(az, el), Math.max(0.1, Number(distance)));
}

function rotatePoint(p) {
    var cy = Math.cos(viewYaw);
    var sy = Math.sin(viewYaw);
    var x = p[0] * cy + p[1] * sy;
    var depth = -p[0] * sy + p[1] * cy;
    var height = p[2] * Math.cos(viewPitch);
    return [x, depth * Math.sin(viewPitch) + height, depth];
}

function norm3(p) {
    var d = Math.sqrt(p[0] * p[0] + p[1] * p[1] + p[2] * p[2]);
    if (d <= 0.000001) return [0, 0, 0];
    return [p[0] / d, p[1] / d, p[2] / d];
}

function distSquared3(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    return dx * dx + dy * dy + dz * dz;
}

function add3(a, b, c) {
    return [a[0] + b[0] + c[0], a[1] + b[1] + c[1], a[2] + b[2] + c[2]];
}

function vecAzimuthDeg(v) {
    return wrapSignedDeg(Math.atan2(v[1], v[0]) * 180 / Math.PI);
}

function vecElevationDeg(v) {
    return Math.atan2(v[2], Math.sqrt(v[0] * v[0] + v[1] * v[1])) * 180 / Math.PI;
}

function icosaFaceCenters() {
    var phi = 1.61803398875;
    var raw = [
        [0, 1, phi], [0, -1, phi], [0, 1, -phi], [0, -1, -phi],
        [1, phi, 0], [-1, phi, 0], [1, -phi, 0], [-1, -phi, 0],
        [phi, 0, 1], [-phi, 0, 1], [phi, 0, -1], [-phi, 0, -1]
    ];
    var verts = [];
    for (var i = 0; i < raw.length; i++) verts.push(norm3(raw[i]));
    var minD2 = 999999;
    for (var a = 0; a < verts.length; a++) {
        for (var b = a + 1; b < verts.length; b++) {
            var d2 = distSquared3(verts[a], verts[b]);
            if (d2 > 0.0001 && d2 < minD2) minD2 = d2;
        }
    }
    var maxD2 = minD2 * 1.08;
    var centers = [];
    for (var ia = 0; ia < verts.length; ia++) {
        for (var ib = ia + 1; ib < verts.length; ib++) {
            if (distSquared3(verts[ia], verts[ib]) > maxD2) continue;
            for (var ic = ib + 1; ic < verts.length; ic++) {
                if (distSquared3(verts[ia], verts[ic]) > maxD2 || distSquared3(verts[ib], verts[ic]) > maxD2) continue;
                centers.push(norm3(add3(verts[ia], verts[ib], verts[ic])));
            }
        }
    }
    return centers;
}

function scalePoint(p, s) {
    return [p[0] * s, p[1] * s, p[2] * s];
}

function depthFront(z) {
    return clamp((Number(z) + 1) * 0.5, 0, 1);
}

function drawPointPath(points) {
    if (!points.length) return;
    mgraphics.move_to(points[0].x, points[0].y);
    for (var i = 1; i < points.length; i++) mgraphics.line_to(points[i].x, points[i].y);
    mgraphics.close_path();
}

function strokedPointPath(points, r, g, b, a) {
    if (!points.length) return;
    set(r, g, b, a);
    mgraphics.set_line_width(1);
    drawPointPath(points);
    mgraphics.stroke();
}

function square(x, y, size, r, g, b, sr, sg, sb, sa) {
    set(r, g, b, 1);
    mgraphics.rectangle(x - size * 0.5, y - size * 0.5, size, size);
    mgraphics.fill();
    set(sr, sg, sb, sa);
    mgraphics.set_line_width(1);
    mgraphics.rectangle(x - size * 0.5 + 0.5, y - size * 0.5 + 0.5, size - 1, size - 1);
    mgraphics.stroke();
}

function line(x1, y1, x2, y2, r, g, b, a) {
    set(r, g, b, a);
    mgraphics.set_line_width(1);
    mgraphics.move_to(x1, y1);
    mgraphics.line_to(x2, y2);
    mgraphics.stroke();
}

function text(s, x, y, r, g, b, size) {
    mgraphics.select_font_face("Arial");
    mgraphics.set_font_size(size);
    set(r, g, b, 1);
    mgraphics.move_to(x, y);
    mgraphics.show_text(String(s));
}

function set(r, g, b, a) {
    mgraphics.set_source_rgba(r, g, b, a);
}

function refresh() {
    if (redrawPending) return;
    redrawPending = 1;
    redrawTask.schedule(16);
}

function doRedraw() {
    redrawPending = 0;
    mgraphics.redraw();
}

function clamp(v, lo, hi) {
    v = Number(v);
    if (!isFinite(v)) return lo;
    return Math.max(lo, Math.min(hi, v));
}

function clampInt(v, lo, hi) {
    return Math.round(clamp(v, lo, hi));
}

function wrapSignedDeg(v) {
    v = Number(v);
    while (v <= -180) v += 360;
    while (v > 180) v -= 360;
    return v;
}
