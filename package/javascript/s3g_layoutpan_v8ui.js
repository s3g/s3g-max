autowatch = 1;
inlets = 1;
outlets = 0;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var inputCount = 8;
var outputCount = 24;
var activeSpeakers = 24;
var layoutName = "dome24";
var methodName = "dist";
var selectedSource = 0;
var paramsState = {
    focus: 1,
    rolloff: 6,
    smooth: 35,
    globalaz: 0,
    globalel: 0,
    globaldist: 0,
    diffusion: 0.35,
    output: -6
};

var speakers = [];
var sources = [];
for (var i = 0; i < 64; i++) speakers.push({ id: i + 1, az: 0, el: 0, distance: 1 });
for (var s = 0; s < 64; s++) sources.push(defaultSource(s));
seedDome24();

var viewYaw = -28 * Math.PI / 180;
var viewPitch = 38 * Math.PI / 180;
var dragX = 0;
var dragY = 0;
var redrawPending = 0;
var redrawTask = new Task(doRedraw, this);
var dragging = 0;
var MIN_VIEW_PITCH = 8 * Math.PI / 180;
var MAX_VIEW_PITCH = 90 * Math.PI / 180;
var viewZoom = 1;
var MIN_VIEW_ZOOM = 0.45;
var MAX_VIEW_ZOOM = 2.5;
var DEFAULT_FIRST_AZ = -30;
var OCTO_FIRST_AZ = -45;

function seedDome24() {
    var data = [
        [-30, 0], [-60, 0], [-90, 0], [-120, 0], [-150, 0], [180, 0], [150, 0], [120, 0], [90, 0], [60, 0], [30, 0], [0, 0],
        [-45, 32], [-90, 32], [-135, 32], [180, 32], [135, 32], [90, 32], [45, 32], [0, 32],
        [-90, 66.6], [180, 66.6], [90, 66.6], [0, 66.6]
    ];
    for (var i = 0; i < data.length; i++) speakers[i] = { id: i + 1, az: data[i][0], el: data[i][1], distance: 1 };
}

function defaultSource(i) {
    var az = i * 45;
    if (az > 180) az -= 360;
    return { id: i + 1, az: az, el: 0, distance: 1, gain: 0, mute: 0, solo: 0 };
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

function applyLayoutPreset(name) {
    var n = normalizeLayoutName(name);
    layoutName = n;
    clearSpeakers();
    if (n == "custom") {
        activeSpeakers = 16;
        outputCount = 16;
        setRing(0, 12, DEFAULT_FIRST_AZ, 0);
        setRing(12, 4, DEFAULT_FIRST_AZ, 66.6);
    } else if (n == "cube8") {
        activeSpeakers = 8;
        outputCount = 8;
        setSpeakerAt(0, -45, -35.2644, 1);
        setSpeakerAt(1, -135, -35.2644, 1);
        setSpeakerAt(2, 135, -35.2644, 1);
        setSpeakerAt(3, 45, -35.2644, 1);
        setSpeakerAt(4, -45, 35.2644, 1);
        setSpeakerAt(5, -135, 35.2644, 1);
        setSpeakerAt(6, 135, 35.2644, 1);
        setSpeakerAt(7, 45, 35.2644, 1);
    } else if (n == "cube17") {
        activeSpeakers = 17;
        outputCount = 17;
        var pts = [
            [1, -1, -1], [-1, -1, -1], [-1, 1, -1], [1, 1, -1],
            [1, -1, 0], [0, -1, 0], [-1, -1, 0], [-1, 0, 0],
            [-1, 1, 0], [0, 1, 0], [1, 1, 0], [1, 0, 0],
            [1, -1, 1], [-1, -1, 1], [-1, 1, 1], [1, 1, 1],
            [0, 0, 1]
        ];
        for (var c = 0; c < pts.length; c++) setSpeakerFromXyz(c, pts[c][0], pts[c][1], pts[c][2]);
    } else if (n == "cube41") {
        activeSpeakers = 41;
        outputCount = 41;
        var cube41 = cube41Xyz();
        for (var c41 = 0; c41 < cube41.length; c41++) setSpeakerFromXyz(c41, cube41[c41][0], cube41[c41][1], cube41[c41][2]);
    } else if (n == "lpac41") {
        activeSpeakers = 41;
        outputCount = 41;
        var lpac41 = lpac41Xyz();
        for (var l41 = 0; l41 < lpac41.length; l41++) setSpeakerFromXyz(l41, lpac41[l41][0], lpac41[l41][1], lpac41[l41][2]);
    } else if (n == "dodeca12") {
        activeSpeakers = 12;
        outputCount = 12;
        setSpeakerAt(0, -31.717474, 0, 1);
        setSpeakerAt(1, -90, -31.717474, 1);
        setSpeakerAt(2, -90, 31.717474, 1);
        setSpeakerAt(3, -148.282526, 0, 1);
        setSpeakerAt(4, 180, -58.282526, 1);
        setSpeakerAt(5, 180, 58.282526, 1);
        setSpeakerAt(6, 148.282526, 0, 1);
        setSpeakerAt(7, 90, -31.717474, 1);
        setSpeakerAt(8, 90, 31.717474, 1);
        setSpeakerAt(9, 31.717474, 0, 1);
        setSpeakerAt(10, 0, -58.282526, 1);
        setSpeakerAt(11, 0, 58.282526, 1);
    } else if (n == "icosahedron20") {
        activeSpeakers = 20;
        outputCount = 20;
        var icoPts = icosaFaceCenters();
        for (var ico = 0; ico < icoPts.length; ico++) {
            setSpeakerFromXyz(ico, icoPts[ico][0], icoPts[ico][1], icoPts[ico][2]);
            speakers[ico].distance = 1;
        }
    } else if (n == "dome25") {
        activeSpeakers = 25;
        outputCount = 25;
        setSrstDome(1);
    } else if (n == "srst25") {
        activeSpeakers = 25;
        outputCount = 25;
        var srst25 = srst25Xyz();
        for (var s25 = 0; s25 < srst25.length; s25++) {
            setSpeakerFromRoomXyz(s25, srst25[s25][0], srst25[s25][1], srst25[s25][2]);
            speakers[s25].distance = 1;
        }
    } else if (n == "dome24") {
        activeSpeakers = 24;
        outputCount = 24;
        setSrstDome(0);
    } else if (n == "double16") {
        activeSpeakers = 16;
        outputCount = 16;
        setRing(0, 8, DEFAULT_FIRST_AZ, 0);
        setRing(8, 8, DEFAULT_FIRST_AZ, 45);
    } else if (n == "double20") {
        activeSpeakers = 20;
        outputCount = 20;
        setRing(0, 12, DEFAULT_FIRST_AZ, 0);
        setRing(12, 8, DEFAULT_FIRST_AZ, 45);
    } else if (n == "octo") {
        activeSpeakers = 8;
        outputCount = 8;
        setRing(0, 8, OCTO_FIRST_AZ, 0);
    } else if (n == "quad") {
        activeSpeakers = 4;
        outputCount = 4;
        setSpeakerAt(0, 45, 0, 1);
        setSpeakerAt(1, -45, 0, 1);
        setSpeakerAt(2, -135, 0, 1);
        setSpeakerAt(3, 135, 0, 1);
    } else if (n == "quad+oh") {
        activeSpeakers = 6;
        outputCount = 6;
        setSpeakerAt(0, 45, 0, 1);
        setSpeakerAt(1, -45, 0, 1);
        setSpeakerAt(2, -135, 0, 1);
        setSpeakerAt(3, 135, 0, 1);
        setSpeakerAt(4, 90, 60, 1);
        setSpeakerAt(5, -90, 60, 1);
    } else if (n == "ring12") {
        activeSpeakers = 12;
        outputCount = 12;
        setRing(0, 12, DEFAULT_FIRST_AZ, 0);
    } else if (n == "ring16") {
        activeSpeakers = 16;
        outputCount = 16;
        setRing(0, 16, DEFAULT_FIRST_AZ, 0);
    } else if (n == "5.0") {
        activeSpeakers = 5;
        outputCount = 5;
        setSurroundBase(5);
    } else if (n == "6.0") {
        activeSpeakers = 6;
        outputCount = 6;
        setSurroundBase(6);
    } else if (n == "7.0") {
        activeSpeakers = 7;
        outputCount = 7;
        setSurroundBase(7);
    } else if (n == "5.0.2") {
        activeSpeakers = 7;
        outputCount = 7;
        setSurroundBase(5);
        setOverheadPair(5);
    } else if (n == "7.0.2") {
        activeSpeakers = 9;
        outputCount = 9;
        setSurroundBase(7);
        setOverheadPair(7);
    } else if (n == "5.0.4") {
        activeSpeakers = 9;
        outputCount = 9;
        setSurroundBase(5);
        setOverheadQuad(5);
    } else if (n == "7.0.4") {
        activeSpeakers = 11;
        outputCount = 11;
        setSurroundBase(7);
        setOverheadRing(7, 4);
    } else if (n == "9.0") {
        activeSpeakers = 9;
        outputCount = 9;
        setSurroundBase(9);
    } else if (n == "9.0.2") {
        activeSpeakers = 11;
        outputCount = 11;
        setSurroundBase(9);
        setOverheadRing(9, 2);
    } else if (n == "9.0.4") {
        activeSpeakers = 13;
        outputCount = 13;
        setSurroundBase(9);
        setOverheadRing(9, 4);
    } else if (n == "9.0.6") {
        activeSpeakers = 15;
        outputCount = 15;
        setSurroundBase(9);
        setOverheadRing(9, 6);
    } else if (n == "7.0.6") {
        activeSpeakers = 13;
        outputCount = 13;
        setSurroundBase(7);
        setOverheadRing(7, 6);
    } else if (n == "11.0.8") {
        activeSpeakers = 19;
        outputCount = 19;
        setSurroundBase(11);
        setOverheadRing(11, 8);
    } else {
        activeSpeakers = 24;
        outputCount = 24;
        setSrstDome(0);
        layoutName = "dome24";
    }
}

function clearSpeakers() {
    for (var i = 0; i < speakers.length; i++) speakers[i] = { id: i + 1, az: 0, el: 0, distance: 1 };
}

function setRing(start, count, startAz, el) {
    for (var i = 0; i < count; i++) setSpeakerAt(start + i, startAz - i * 360 / count, el, 1);
}

function setSpeakerAt(index, az, el, distance) {
    if (index < 0 || index >= speakers.length) return;
    speakers[index] = { id: index + 1, az: wrapDeg(az), el: Number(el), distance: Math.max(0.1, Number(distance)) };
}

function setSrstDome(includeZenith) {
    var lower = [-30, -60, -90, -120, -150, 180, 150, 120, 90, 60, 30, 0];
    var middle = [-45, -90, -135, 180, 135, 90, 45, 0];
    var upper = [-90, 180, 90, 0];
    for (var i = 0; i < lower.length; i++) setSpeakerAt(i, lower[i], 0, 1);
    for (var m = 0; m < middle.length; m++) setSpeakerAt(12 + m, middle[m], 32, 1);
    for (var u = 0; u < upper.length; u++) setSpeakerAt(20 + u, upper[u], 66.6, 1);
    if (includeZenith) setSpeakerAt(24, 0, 90, 1);
}

function setSurroundBase(count) {
    if (count == 5) {
        setSpeakerAt(0, -30, 0, 1);
        setSpeakerAt(1, -110, 0, 1);
        setSpeakerAt(2, 110, 0, 1);
        setSpeakerAt(3, 30, 0, 1);
        setSpeakerAt(4, 0, 0, 1);
    } else if (count == 6) {
        setSpeakerAt(0, -30, 0, 1);
        setSpeakerAt(1, -110, 0, 1);
        setSpeakerAt(2, 180, 0, 1);
        setSpeakerAt(3, 110, 0, 1);
        setSpeakerAt(4, 30, 0, 1);
        setSpeakerAt(5, 0, 0, 1);
    } else if (count == 7) {
        setSpeakerAt(0, -30, 0, 1);
        setSpeakerAt(1, -110, 0, 1);
        setSpeakerAt(2, -150, 0, 1);
        setSpeakerAt(3, 150, 0, 1);
        setSpeakerAt(4, 110, 0, 1);
        setSpeakerAt(5, 30, 0, 1);
        setSpeakerAt(6, 0, 0, 1);
    } else if (count == 9) {
        var nine = [-30, -60, -110, -150, 150, 110, 60, 30, 0];
        for (var n9 = 0; n9 < nine.length; n9++) setSpeakerAt(n9, nine[n9], 0, 1);
    } else if (count == 11) {
        var eleven = [-30, -50, -70, -110, -150, 180, 150, 110, 70, 30, 0];
        for (var n11 = 0; n11 < eleven.length; n11++) setSpeakerAt(n11, eleven[n11], 0, 1);
    }
}

function setOverheadPair(base) {
    setSpeakerAt(base, -45, 60, 0.88);
    setSpeakerAt(base + 1, 45, 60, 0.88);
}

function setOverheadQuad(base) {
    setSpeakerAt(base, -45, 55, 0.9);
    setSpeakerAt(base + 1, -135, 55, 0.9);
    setSpeakerAt(base + 2, 135, 55, 0.9);
    setSpeakerAt(base + 3, 45, 55, 0.9);
}

function setOverheadRing(base, count) {
    if (count == 2) {
        setOverheadPair(base);
    } else if (count == 4) {
        setOverheadQuad(base);
    } else if (count == 6) {
        var six = [-45, -90, -135, 135, 90, 45];
        for (var s6 = 0; s6 < six.length; s6++) setSpeakerAt(base + s6, six[s6], 55, 0.9);
    } else if (count == 8) {
        var eight = [-30, -75, -120, -165, 165, 120, 75, 30];
        for (var s8 = 0; s8 < eight.length; s8++) setSpeakerAt(base + s8, eight[s8], 55, 0.9);
    }
}

function setSpeakerFromXyz(index, x, y, z) {
    var h = Math.sqrt(x * x + y * y);
    var distance = Math.sqrt(x * x + y * y + z * z);
    var az = Math.atan2(y, x) * 180 / Math.PI;
    var el = Math.atan2(z, h) * 180 / Math.PI;
    setSpeakerAt(index, az, el, distance);
}

function setSpeakerFromRoomXyz(index, x, y, z) {
    var h = Math.sqrt(x * x + y * y);
    var distance = Math.sqrt(x * x + y * y + z * z);
    var az = -Math.atan2(x, y) * 180 / Math.PI;
    var el = Math.atan2(z, h) * 180 / Math.PI;
    setSpeakerAt(index, az, el, distance);
}

function normalizeLayoutName(name) {
    if (typeof name == "number") return layoutNameFromNumber(name);
    var n = String(name).toLowerCase();
    n = n.replace(/^\s+|\s+$/g, "");
    n = n.replace(/\s+/g, "");
    if (n == "cube") return "cube8";
    if (n == "cube41") return "cube41";
    if (n == "lpac41") return "lpac41";
    if (n == "srst25") return "srst25";
    if (n == "dodeca") return "dodeca12";
    if (n == "icosa20" || n == "ico20") return "icosahedron20";
    if (n == "dome") return "dome24";
    if (n == "fivezero" || n == "five0") return "5.0";
    if (n == "sixzero" || n == "six0") return "6.0";
    if (n == "sevenzero" || n == "seven0") return "7.0";
    if (n == "fivezerotwo" || n == "five02") return "5.0.2";
    if (n == "sevenzerotwo" || n == "seven02") return "7.0.2";
    if (n == "fivezerofour" || n == "five04") return "5.0.4";
    if (n == "sevenzerofour" || n == "seven04" || n == "7.0.4.") return "7.0.4";
    if (n == "ninezero" || n == "nine0") return "9.0";
    if (n == "ninezerotwo" || n == "nine02") return "9.0.2";
    if (n == "ninezerofour" || n == "nine04") return "9.0.4";
    if (n == "ninezerosix" || n == "nine06") return "9.0.6";
    if (n == "sevenzerosix" || n == "seven06") return "7.0.6";
    if (n == "elevenzeroeight" || n == "eleven08") return "11.0.8";
    if (n == "octo8" || n == "octophonic" || n == "octoring") return "octo";
    if (n == "quad6" || n == "quadoh" || n == "quad-oh" || n == "quadoverhead") return "quad+oh";
    if (n == "ring") return "ring16";
    return n;
}

function layoutNameFromNumber(value) {
    var rounded = Math.round(Number(value));
    if (Math.abs(Number(value) - rounded) < 0.000001) {
        if (rounded == 5) return "5.0";
        if (rounded == 6) return "6.0";
        if (rounded == 7) return "7.0";
        if (rounded == 9) return "9.0";
        return layoutNameForIndex(rounded);
    }
    var s = String(value);
    if (s == "5") return "5.0";
    if (s == "6") return "6.0";
    if (s == "7") return "7.0";
    if (s == "9") return "9.0";
    return s;
}

function layoutNameForIndex(index) {
    var names = ["custom", "cube8", "cube17", "dodeca12", "dome24", "dome25", "double16", "double20", "octo", "quad", "quad+oh", "ring12", "ring16", "5.0", "6.0", "7.0", "5.0.2", "7.0.2", "5.0.4", "7.0.4", "9.0", "9.0.2", "9.0.4", "9.0.6", "7.0.6", "11.0.8", "icosahedron20", "cube41", "lpac41", "srst25"];
    var i = clamp(Math.round(Number(index)), 0, names.length - 1);
    return names[i];
}

function config() {
    var a = arrayfromargs(arguments);
    inputCount = clamp(intOr(a[0], inputCount), 1, sources.length);
    outputCount = intOr(a[1], outputCount);
    activeSpeakers = intOr(a[2], activeSpeakers);
    refresh();
}

function layout() {
    var a = arrayfromargs(arguments);
    applyLayoutPreset(a.length > 1 ? a[1] : a[0]);
    refresh();
}

function method() {
    var a = arrayfromargs(arguments);
    methodName = String(a.length > 1 ? a[1] : a[0]);
    refresh();
}

function params() {
    var a = arrayfromargs(arguments);
    if (a.length < 9) return;
    paramsState.focus = Number(a[0]);
    paramsState.rolloff = Number(a[1]);
    paramsState.smooth = Number(a[2]);
    paramsState.globalaz = Number(a[3]);
    paramsState.globalel = Number(a[4]);
    paramsState.globaldist = Number(a[5]);
    paramsState.diffusion = Number(a[6]);
    paramsState.output = Number(a[7]);
    selectedSource = clamp(Math.round(Number(a[8])) - 1, 0, sources.length - 1);
    refresh();
}

function speaker() {
    var a = arrayfromargs(arguments);
    if (a.length < 4) return;
    var i = clamp(Math.round(Number(a[0])) - 1, 0, 63);
    speakers[i] = { id: i + 1, az: Number(a[1]), el: Number(a[2]), distance: Math.max(0.1, Number(a[3])) };
    refresh();
}

function source() {
    var a = arrayfromargs(arguments);
    if (a.length < 4) return;
    var i = clamp(Math.round(Number(a[0])) - 1, 0, sources.length - 1);
    sources[i] = {
        id: i + 1,
        az: Number(a[1]),
        el: Number(a[2]),
        distance: Math.max(0.1, Number(a[3])),
        gain: a.length > 4 ? Number(a[4]) : sources[i].gain,
        mute: a.length > 5 ? Number(a[5]) : sources[i].mute,
        solo: a.length > 6 ? Number(a[6]) : sources[i].solo
    };
    refresh();
}

function done() { refresh(); }
function bang() { refresh(); }
function active() { refresh(); }

function paint() {
    var w = box.rect[2] - box.rect[0];
    var h = box.rect[3] - box.rect[1];
    background(w, h);
    drawDome(w, h);
}

function background(w, h) {
    set(0.055, 0.06, 0.067, 1);
    mgraphics.rectangle(0, 0, w, h);
    mgraphics.fill();
}

function drawDome(w, h) {
    var cx = w * 0.5;
    var cy = h * 0.54;
    var radius = Math.min(w, h) * 0.35;
    var scale = viewScale();
    var projectedSpeakers = projectSpeakers(cx, cy, radius, scale);

    projectedSpeakers.sort(function(a, b) { return b.z - a.z; });
    drawDistancePlane(cx, cy, radius, scale);
    drawDomeShell(cx, cy, radius, scale);
    drawPolyhedronShell(cx, cy, radius, scale);
    drawSpeakerFacets(projectedSpeakers);
    drawSpeakerEdges(projectedSpeakers);
    drawSources(cx, cy, radius, scale);
    drawSpeakers(projectedSpeakers);
    drawLabels(w, h);
}

function projectSpeakers(cx, cy, radius, scale) {
    var projected = [];
    for (var i = 0; i < activeSpeakers; i++) {
        var p = pointFromAzElDistance(speakers[i].az, speakers[i].el, speakers[i].distance);
        var rp = rotatePoint(p);
        projected.push({
            id: speakers[i].id,
            az: speakers[i].az,
            el: speakers[i].el,
            p: p,
            r: rp,
            x: cx + rp[0] * radius * scale,
            y: cy - rp[1] * radius * scale,
            z: rp[2]
        });
    }
    return projected;
}

function viewScale() {
    return viewZoom;
}

function planeSquash() {
    return Math.sin(viewPitch);
}

function domeHeight() {
    return Math.cos(viewPitch);
}

function depthCueAmount() {
    return clamp(domeHeight() / Math.cos(MIN_VIEW_PITCH), 0, 1);
}

function drawDistancePlane(cx, cy, radius, scale) {
    var plane = radius * scale * distanceProjection(3);
    planePolygonBand(cx, cy, plane, 0.045, 1);
    planePolygonBand(cx, cy, plane * distanceProjection(2) / distanceProjection(3), 0.065, 0);
    planePolygonBand(cx, cy, radius * scale, 0.085, 0);
}

function drawDomeShell(cx, cy, radius, scale) {
    strokedPlanePolygon(cx, cy, radius * scale, 0.34, 0.34, 0.34, 0.42);
}

function planePolygonBand(cx, cy, radius, alpha, fill) {
    var points = bottomTierPlanePoints(cx, cy, radius);
    if (points.length < 3) return;
    if (fill) {
        set(0.44, 0.44, 0.44, alpha);
        drawPointPath(points);
        mgraphics.fill();
    }
    strokedPointPath(points, 0.58, 0.58, 0.58, alpha + 0.055);
}

function strokedPlanePolygon(cx, cy, radius, r, g, b, alpha) {
    var points = bottomTierPlanePoints(cx, cy, radius);
    if (points.length < 3) return;
    strokedPointPath(points, r, g, b, alpha);
}

function bottomTierPlanePoints(cx, cy, radius) {
    var points = [];
    var bottom = lowestElevationSpeakers();
    for (var i = 0; i < bottom.length; i++) {
        var p = pointFromAzElDistance(bottom[i].az, bottom[i].el, bottom[i].distance);
        var rp = rotatePoint(p);
        points.push({ x: cx + rp[0] * radius, y: cy - rp[1] * radius, z: rp[2] });
    }
    points.sort(function(a, b) {
        return Math.atan2(a.y - cy, a.x - cx) - Math.atan2(b.y - cy, b.x - cx);
    });
    return points;
}

function strokedPointPath(points, r, g, b, alpha) {
    if (mgraphics.set_line_width) mgraphics.set_line_width(1);
    set(r, g, b, alpha);
    drawPointPath(points);
    mgraphics.stroke();
}

function drawPointPath(points) {
    if (points.length < 1) return;
    mgraphics.move_to(points[0].x, points[0].y);
    for (var i = 1; i < points.length; i++) mgraphics.line_to(points[i].x, points[i].y);
    mgraphics.close_path();
}

function drawSpeakerEdges(projected) {
    var byId = projectedById(projected);
    var edges = buildSpeakerEdges(projected);
    for (var e = 0; e < edges.length; e++) {
        var a = byId[edges[e][0]];
        var b = byId[edges[e][1]];
        if (!a || !b) continue;
        var front = depthFront((a.z + b.z) * 0.5);
        set(0.52, 0.52, 0.52, 0.09 + 0.22 * front);
        mgraphics.move_to(a.x, a.y);
        mgraphics.line_to(b.x, b.y);
        mgraphics.stroke();
    }
}

function drawPolyhedronShell(cx, cy, radius, scale) {
    var key = layoutKey();
    if (key != "dodeca12" && key != "icosahedron20") return;
    var verts = key == "dodeca12" ? dodecaShellVertices() : icosaShellVertices();
    var edges = nearestVertexEdges(verts);
    var projected = [];
    for (var i = 0; i < verts.length; i++) {
        var p = norm3(verts[i]);
        var rp = rotatePoint(p);
        projected.push({ x: cx + rp[0] * radius * scale, y: cy - rp[1] * radius * scale, z: rp[2] });
    }
    for (var e = 0; e < edges.length; e++) {
        var a = projected[edges[e][0]];
        var b = projected[edges[e][1]];
        var front = depthFront((a.z + b.z) * 0.5);
        set(0.56, 0.56, 0.56, 0.08 + 0.18 * front);
        mgraphics.move_to(a.x, a.y);
        mgraphics.line_to(b.x, b.y);
        mgraphics.stroke();
    }
}

function drawSpeakerFacets(projected) {
    var byId = projectedById(projected);
    var facets = buildSpeakerFacets();
    for (var f = 0; f < facets.length; f++) {
        var a = byId[facets[f][0]];
        var b = byId[facets[f][1]];
        var c = byId[facets[f][2]];
        if (!a || !b || !c) continue;
        var front = depthFront((a.z + b.z + c.z) / 3);
        set(0.42, 0.42, 0.42, 0.030 + 0.050 * front);
        mgraphics.move_to(a.x, a.y);
        mgraphics.line_to(b.x, b.y);
        mgraphics.line_to(c.x, c.y);
        mgraphics.close_path();
        mgraphics.fill();

        set(0.60, 0.60, 0.60, 0.10 + 0.20 * front);
        mgraphics.move_to(a.x, a.y);
        mgraphics.line_to(b.x, b.y);
        mgraphics.line_to(c.x, c.y);
        mgraphics.close_path();
        mgraphics.stroke();
    }
}

function drawSourceRays(cx, cy, radius, scale, projectedSpeakers) {
    if (selectedSource < 0 || selectedSource >= inputCount) return;
    var src = sourceProjection(selectedSource, cx, cy, radius, scale);
    var candidates = [];
    for (var i = 0; i < projectedSpeakers.length; i++) {
        candidates.push({ speaker: projectedSpeakers[i], d: dist3(src.p, projectedSpeakers[i].p) });
    }
    candidates.sort(function(a, b) { return a.d - b.d; });
    var count = Math.min(6, candidates.length);
    var color = sourceAedColor(src.az, src.el, src.distance, src.id == selectedSource + 1);
    for (var j = count - 1; j >= 0; j--) {
        var sp = candidates[j].speaker;
        var alpha = 0.07 + 0.17 * (1 - j / Math.max(1, count - 1));
        set(color[0], color[1], color[2], alpha);
        mgraphics.move_to(src.x, src.y);
        mgraphics.line_to(sp.x, sp.y);
        mgraphics.stroke();
    }
}

function drawSources(cx, cy, radius, scale) {
    var projected = [];
    for (var i = 0; i < inputCount; i++) projected.push(sourceProjection(i, cx, cy, radius, scale));
    projected.sort(function(a, b) { return b.z - a.z; });
    for (var s = 0; s < projected.length; s++) {
        var item = projected[s];
        var c = sourceAedColor(item.az, item.el, item.distance, item.id == selectedSource + 1);
        var front = depthFront(item.z);
        var size = sourceDotSize(item.distance) + 2 * front;
        var alpha = item.mute ? 0.28 : (item.solo ? 1.0 : 0.78 + 0.22 * front);
        set(c[0], c[1], c[2], 0.16 + 0.16 * front);
        mgraphics.rectangle(item.x - size - 5, item.y - size - 5, (size + 5) * 2, (size + 5) * 2);
        mgraphics.fill();
        set(c[0], c[1], c[2], alpha);
        mgraphics.rectangle(item.x - size, item.y - size, size * 2, size * 2);
        mgraphics.fill();
        set(0.05, 0.055, 0.065, 0.92);
        if (mgraphics.set_line_width) mgraphics.set_line_width(1);
        mgraphics.rectangle(item.x - size, item.y - size, size * 2, size * 2);
        mgraphics.stroke();
        if (item.id == selectedSource + 1) {
            set(0.92, 0.92, 0.92, 0.90);
            if (mgraphics.set_line_width) mgraphics.set_line_width(1.5);
            mgraphics.rectangle(item.x - size - 6, item.y - size - 6, (size + 6) * 2, (size + 6) * 2);
            mgraphics.stroke();
        }
        set(0.05, 0.055, 0.065, 0.92);
        mgraphics.select_font_face("Arial");
        mgraphics.set_font_size(10);
        mgraphics.move_to(item.x - 3, item.y + 4);
        mgraphics.show_text(String(item.id));
    }
}

function sourceProjection(index, cx, cy, radius, scale) {
    var distance = Math.max(0.1, sources[index].distance);
    var p = scalePoint(pointFromAzEl(sources[index].az, sources[index].el), distanceProjection(distance));
    var rp = rotatePoint(p);
    return {
        id: sources[index].id,
        az: sources[index].az,
        el: sources[index].el,
        p: p,
        r: rp,
        x: cx + rp[0] * radius * scale,
        y: cy - rp[1] * radius * scale,
        z: rp[2],
        distance: distance,
        mute: sources[index].mute,
        solo: sources[index].solo
    };
}

function drawSpeakers(projected) {
    for (var i = 0; i < projected.length; i++) {
        var s = projected[i];
        var front = depthFront(s.z);
        var size = 5 + 2 * front;
        set(0.08, 0.08, 0.085, 0.58 + 0.24 * front);
        mgraphics.rectangle(s.x - size * 0.68, s.y - size * 0.68, size * 1.36, size * 1.36);
        mgraphics.fill();
        set(0.50 + 0.25 * front, 0.50 + 0.25 * front, 0.50 + 0.25 * front, 0.66 + 0.30 * front);
        mgraphics.rectangle(s.x - size * 0.5, s.y - size * 0.5, size, size);
        mgraphics.fill();
        set(0.78, 0.78, 0.78, 0.42 + 0.32 * front);
        mgraphics.select_font_face("Arial");
        mgraphics.set_font_size(activeSpeakers > 32 ? 7 : 8);
        mgraphics.move_to(s.x + size + 2, s.y + 3);
        mgraphics.show_text(String(s.id));
    }
}

function drawLabels(w, h) {
    set(0.76, 0.76, 0.76, 0.78);
    mgraphics.select_font_face("Arial");
    mgraphics.set_font_size(11);
    mgraphics.move_to(14, h - 16);
    mgraphics.show_text("drag to rotate");
}

function list() {
    var a = arrayfromargs(arguments);
    if (a.length >= 32) {
        for (var i = 0; i + 3 < a.length && i / 4 < sources.length; i += 4) {
            var index = Number(a[i]);
            if (index < 1 || index > sources.length) continue;
            sources[index - 1].az = Number(a[i + 1]);
            sources[index - 1].el = Number(a[i + 2]);
            sources[index - 1].distance = Math.max(0.1, Number(a[i + 3]));
        }
        refresh();
    }
}

function view(name) {
    var v = String(name);
    if (v == "front") {
        viewYaw = 0;
        viewPitch = 0;
    } else if (v == "right" || v == "side") {
        viewYaw = -Math.PI * 0.5;
        viewPitch = 0;
    } else if (v == "top") {
        viewYaw = -Math.PI * 0.5;
        viewPitch = Math.PI * 0.5;
    } else if (v == "iso" || v == "3/4") {
        viewYaw = -28 * Math.PI / 180;
        viewPitch = 38 * Math.PI / 180;
    }
    refresh();
}

function zoom(value) {
    var z = Number(value);
    if (!isFinite(z)) return;
    viewZoom = clamp(z, MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function zoomin(amount) {
    viewZoom = clamp(viewZoom * validNumber(amount, 1.2), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function zoomout(amount) {
    viewZoom = clamp(viewZoom / validNumber(amount, 1.2), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function wheelzoom(delta) {
    var d = validNumber(delta, 0);
    if (d === 0) return;
    var steps = Math.max(-6, Math.min(6, d / 120));
    if (Math.abs(steps) < 0.01) steps = d > 0 ? 1 : -1;
    viewZoom = clamp(viewZoom * Math.pow(1.12, steps), MIN_VIEW_ZOOM, MAX_VIEW_ZOOM);
    refresh();
}

function handleWheelArgs(args) {
    var a = [];
    if (args && typeof args.length == "number") {
        for (var i = 0; i < args.length; i++) a.push(args[i]);
    } else {
        a = arrayfromargs(arguments);
    }
    var delta = 0;
    for (var j = 0; j < a.length; j++) {
        var v = Number(a[j]);
        if (isFinite(v) && v !== 0) delta = v;
    }
    wheelzoom(delta);
}

function onmousewheel() {
    handleWheelArgs(arguments);
}

function mousewheel() {
    handleWheelArgs(arguments);
}

function wheel() {
    handleWheelArgs(arguments);
}

function scroll() {
    handleWheelArgs(arguments);
}

function onscroll() {
    handleWheelArgs(arguments);
}

function resetzoom() {
    viewZoom = 1;
    refresh();
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

function refresh() {
    if (redrawPending) return;
    redrawPending = 1;
    redrawTask.schedule(16);
}

function doRedraw() {
    redrawPending = 0;
    mgraphics.redraw();
}

function buildSpeakerEdges(projected) {
    if (layoutKey() == "dodeca12" || layoutKey() == "icosahedron20") return [];
    return sameElevationSpeakerEdges();
}

function sameElevationSpeakerEdges() {
    var edges = [];
    var seen = {};
    var bands = speakerBands();
    for (var b = 0; b < bands.length; b++) {
        var ids = idsForBand(bands[b]);
        if (ids.length < 2) continue;
        addClosedPathEdges(edges, seen, ids);
    }
    return activeEdges(edges);
}

function buildSpeakerFacets() {
    return [];
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
            var d2 = dist3(norm3(vertices[a]), norm3(vertices[b]));
            d2 *= d2;
            if (d2 > 0.0001 && d2 < minD2) minD2 = d2;
        }
    }
    var maxD2 = minD2 * 1.08;
    for (var i = 0; i < vertices.length; i++) {
        for (var j = i + 1; j < vertices.length; j++) {
            var d = dist3(norm3(vertices[i]), norm3(vertices[j]));
            if (d * d <= maxD2) edges.push([i, j]);
        }
    }
    return edges;
}

function layoutKey() {
    return normalizeLayoutName(layoutName);
}

function cube8Edges() {
    var edges = [];
    var seen = {};
    addClosedPathEdges(edges, seen, [1, 2, 3, 4]);
    addClosedPathEdges(edges, seen, [5, 6, 7, 8]);
    addUniqueEdge(edges, seen, 1, 5);
    addUniqueEdge(edges, seen, 2, 6);
    addUniqueEdge(edges, seen, 3, 7);
    addUniqueEdge(edges, seen, 4, 8);
    return activeEdges(edges);
}

function cube17Edges() {
    var edges = [];
    var seen = {};
    addClosedPathEdges(edges, seen, [1, 2, 3, 4]);
    addClosedPathEdges(edges, seen, [5, 6, 7, 8, 9, 10, 11, 12]);
    addClosedPathEdges(edges, seen, [13, 14, 15, 16]);
    addPathEdges(edges, seen, [1, 5, 13]);
    addPathEdges(edges, seen, [2, 7, 14]);
    addPathEdges(edges, seen, [3, 9, 15]);
    addPathEdges(edges, seen, [4, 11, 16]);
    addUniqueEdge(edges, seen, 13, 17);
    addUniqueEdge(edges, seen, 14, 17);
    addUniqueEdge(edges, seen, 15, 17);
    addUniqueEdge(edges, seen, 16, 17);
    return activeEdges(edges);
}

function quadOverheadEdges() {
    var edges = [];
    var seen = {};
    addClosedPathEdges(edges, seen, [1, 2, 3, 4]);
    addUniqueEdge(edges, seen, 5, 1);
    addUniqueEdge(edges, seen, 5, 4);
    addUniqueEdge(edges, seen, 6, 2);
    addUniqueEdge(edges, seen, 6, 3);
    addUniqueEdge(edges, seen, 5, 6);
    return activeEdges(edges);
}

function isSurroundLayout(k) {
    return k == "5.0" || k == "6.0" || k == "7.0" || k == "9.0"
        || k == "5.0.2" || k == "7.0.2" || k == "9.0.2"
        || k == "5.0.4" || k == "7.0.4" || k == "9.0.4"
        || k == "7.0.6" || k == "9.0.6" || k == "11.0.8";
}

function surroundEdges() {
    var edges = [];
    var seen = {};
    var k = layoutKey();
    var parts = k.split(".");
    var bed = intOr(parts[0], 0);
    var height = parts.length > 2 ? intOr(parts[2], 0) : 0;
    addSurroundBedEdges(edges, seen, bed);
    addSurroundHeightEdges(edges, seen, bed, height);
    return activeEdges(edges);
}

function triangulatedSpeakerEdges(projected) {
    var edges = [];
    var seen = {};
    var bands = speakerBands();
    var byId = projectedById(projected);
    var stableById = stableSpeakerPointsById();
    for (var b = 0; b < bands.length; b++) {
        var split = splitBandIds(bands[b]);
        var ids = split.perimeter;
        if (ids.length > 1) {
            for (var i = 0; i < ids.length; i++) addClearProjectedEdge(edges, seen, ids[i], ids[(i + 1) % ids.length], stableById);
        }
        for (var c = 0; c < split.centers.length; c++) {
            var bracket = lowerBracketIds(split.centers[c], ids);
            for (var k = 0; k < bracket.length; k++) addClearProjectedEdge(edges, seen, split.centers[c], bracket[k], stableById);
        }
    }
    for (var t = 0; t + 1 < bands.length; t++) {
        var lower = splitBandIds(bands[t]).perimeter;
        var upperSplit = splitBandIds(bands[t + 1]);
        var upper = upperSplit.perimeter.concat(upperSplit.centers);
        for (var u = 0; u < upper.length; u++) {
            var bracket = lowerBracketIds(upper[u], lower);
            for (var j = 0; j < bracket.length; j++) addClearProjectedEdge(edges, seen, upper[u], bracket[j], stableById);
        }
    }
    return activeEdges(edges);
}

function splitBandIds(band) {
    var ids = idsForBand(band);
    ids.sort(function(a, b) { return azKey(speakerAz(a)) - azKey(speakerAz(b)); });
    var perimeter = [];
    var centers = [];
    for (var i = 0; i < ids.length; i++) {
        var az = wrapSignedDeg(speakerAz(ids[i]));
        if (ids.length > 4 && Math.abs(az) < 1.0) centers.push(ids[i]);
        else perimeter.push(ids[i]);
    }
    return { perimeter: perimeter, centers: centers };
}

function stableSpeakerPointsById() {
    var byId = {};
    for (var i = 0; i < activeSpeakers; i++) {
        var p = pointFromAzElDistance(speakers[i].az, speakers[i].el, speakers[i].distance);
        byId[speakers[i].id] = { x: p[0], y: p[1] };
    }
    return byId;
}

function addClearProjectedEdge(edges, seen, a, b, byId) {
    if (a == b) return;
    var key = edgeKey(a, b);
    if (seen[key]) return;
    var pa = byId[a];
    var pb = byId[b];
    if (!pa || !pb) return;
    if (Math.abs(pa.x - pb.x) < 0.5 && Math.abs(pa.y - pb.y) < 0.5) return;
    for (var i = 0; i < edges.length; i++) {
        var ea = edges[i][0];
        var eb = edges[i][1];
        if (ea == a || ea == b || eb == a || eb == b) continue;
        if (segmentsIntersectProjected(pa, pb, byId[ea], byId[eb])) return;
    }
    seen[key] = 1;
    edges.push([a, b]);
}

function segmentsIntersectProjected(a, b, c, d) {
    if (!a || !b || !c || !d) return false;
    var o1 = orientProjected(a, b, c);
    var o2 = orientProjected(a, b, d);
    var o3 = orientProjected(c, d, a);
    var o4 = orientProjected(c, d, b);
    return o1 * o2 < -0.000001 && o3 * o4 < -0.000001;
}

function orientProjected(a, b, c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

function addSurroundBedEdges(edges, seen, bed) {
    if (bed == 5) {
        addClosedPathEdges(edges, seen, [1, 2, 3, 4]);
        addUniqueEdge(edges, seen, 5, 1);
        addUniqueEdge(edges, seen, 5, 4);
    } else if (bed == 6) {
        addClosedPathEdges(edges, seen, [5, 1, 2, 3, 4]);
        addUniqueEdge(edges, seen, 6, 1);
        addUniqueEdge(edges, seen, 6, 5);
    } else if (bed == 7) {
        addClosedPathEdges(edges, seen, [6, 1, 2, 3, 4, 5]);
        addUniqueEdge(edges, seen, 7, 1);
        addUniqueEdge(edges, seen, 7, 6);
    } else if (bed == 9) {
        addClosedPathEdges(edges, seen, [8, 1, 2, 3, 4, 5, 6, 7]);
        addUniqueEdge(edges, seen, 9, 1);
        addUniqueEdge(edges, seen, 9, 8);
    } else if (bed == 11) {
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
    if (bed == 5 && height == 2) return [[1, 2], [3, 4]];
    if (bed == 7 && height == 2) return [[2, 3], [4, 5]];
    if (bed == 9 && height == 2) return [[3, 4], [5, 6]];
    if (bed == 5 && height == 4) return [[1, 2], [2, 3], [3, 4], [4, 1]];
    if (bed == 7 && height == 4) return [[6, 1], [2, 3], [4, 5], [5, 6]];
    if (bed == 9 && height == 4) return [[8, 1, 2], [3, 4], [5, 6], [7, 8]];
    if (bed == 7 && height == 6) return [[6, 1], [1, 2], [2, 3], [4, 5], [5, 6], [6, 1]];
    if (bed == 9 && height == 6) return [[8, 1, 2], [2, 3], [3, 4], [5, 6], [6, 7], [7, 8]];
    if (bed == 11 && height == 8) return [[10, 1, 2], [2, 3], [3, 4], [4, 5], [7, 8], [8, 9], [9, 10], [10, 1]];
    return [];
}

function addClosedPathEdges(edges, seen, ids) {
    for (var i = 0; i < ids.length; i++) addUniqueEdge(edges, seen, ids[i], ids[(i + 1) % ids.length]);
}

function addPathEdges(edges, seen, ids) {
    for (var i = 0; i + 1 < ids.length; i++) addUniqueEdge(edges, seen, ids[i], ids[i + 1]);
}

function activeEdges(edges) {
    var filtered = [];
    for (var i = 0; i < edges.length; i++) {
        if (edges[i][0] <= activeSpeakers && edges[i][1] <= activeSpeakers) filtered.push(edges[i]);
    }
    return filtered;
}

function dodecaHullFacets() {
    var edges = nearestSpeakerEdges(5);
    var connected = {};
    for (var e = 0; e < edges.length; e++) connected[edgeKey(edges[e][0], edges[e][1])] = 1;
    var facets = [];
    for (var a = 1; a <= activeSpeakers; a++) {
        for (var b = a + 1; b <= activeSpeakers; b++) {
            if (!connected[edgeKey(a, b)]) continue;
            for (var c = b + 1; c <= activeSpeakers; c++) {
                if (connected[edgeKey(a, c)] && connected[edgeKey(b, c)]) facets.push([a, b, c]);
            }
        }
    }
    return facets;
}

function nearestSpeakerEdges(neighborCount) {
    var edges = [];
    var seen = {};
    for (var i = 0; i < activeSpeakers; i++) {
        var pi = pointFromAzElDistance(speakers[i].az, speakers[i].el, speakers[i].distance);
        var candidates = [];
        for (var j = 0; j < activeSpeakers; j++) {
            if (i == j) continue;
            var pj = pointFromAzElDistance(speakers[j].az, speakers[j].el, speakers[j].distance);
            candidates.push({ id: j + 1, d: dist3(pi, pj) });
        }
        candidates.sort(function(a, b) { return a.d - b.d; });
        for (var n = 0; n < Math.min(neighborCount, candidates.length); n++) addUniqueEdge(edges, seen, i + 1, candidates[n].id);
    }
    return edges;
}

function edgeKey(a, b) {
    return Math.min(a, b) + ":" + Math.max(a, b);
}

function speakerBands() {
    var bands = [];
    for (var i = 0; i < activeSpeakers; i++) {
        var placed = 0;
        for (var b = 0; b < bands.length; b++) {
            if (Math.abs(bands[b][0].el - speakers[i].el) < 8) {
                bands[b].push(speakers[i]);
                placed = 1;
                break;
            }
        }
        if (!placed) bands.push([speakers[i]]);
    }
    bands.sort(function(a, b) { return a[0].el - b[0].el; });
    for (var j = 0; j < bands.length; j++) bands[j].sort(function(a, b) { return azKey(a.az) - azKey(b.az); });
    return bands;
}

function idsForBand(band) {
    var ids = [];
    for (var i = 0; i < band.length; i++) ids.push(band[i].id);
    return ids;
}

function lowestElevationSpeakers() {
    var bands = speakerBands();
    return bands.length ? bands[0] : [];
}

function addFanFacets(facets, lowerIds, upperIds) {
    if (lowerIds.length < 2 || upperIds.length < 1) return;
    if (upperIds.length === 1) {
        for (var apex = 0; apex < lowerIds.length; apex++) facets.push([lowerIds[apex], lowerIds[(apex + 1) % lowerIds.length], upperIds[0]]);
        return;
    }
    for (var i = 0; i < upperIds.length; i++) {
        var bracket = lowerBracketIds(upperIds[i], lowerIds);
        if (bracket.length == 2) {
            facets.push([bracket[0], bracket[1], upperIds[i]]);
        } else if (bracket.length == 3) {
            facets.push([bracket[0], bracket[1], upperIds[i]]);
            facets.push([bracket[1], bracket[2], upperIds[i]]);
        }
    }
}

function lowerBracketIds(upperId, lowerIds) {
    var upperAz = azKey(speakerAz(upperId));
    var lower = lowerIds.slice(0);
    lower.sort(function(a, b) { return azKey(speakerAz(a)) - azKey(speakerAz(b)); });
    for (var i = 0; i < lower.length; i++) {
        if (Math.abs(azKey(speakerAz(lower[i])) - upperAz) < 0.01) return [lower[positiveModulo(i - 1, lower.length)], lower[i], lower[(i + 1) % lower.length]];
    }
    for (var j = 0; j < lower.length; j++) {
        var a = lower[j];
        var b = lower[(j + 1) % lower.length];
        var aAz = azKey(speakerAz(a));
        var bAz = azKey(speakerAz(b));
        if (bAz < aAz) bAz += 360;
        var testAz = upperAz < aAz ? upperAz + 360 : upperAz;
        if (testAz > aAz && testAz < bAz) return [a, b];
    }
    return lower.length > 1 ? [lower[0], lower[1]] : [];
}

function uniqueEdgesFromFacets(facets) {
    var edges = [];
    var seen = {};
    for (var i = 0; i < facets.length; i++) {
        addUniqueEdge(edges, seen, facets[i][0], facets[i][1]);
        addUniqueEdge(edges, seen, facets[i][1], facets[i][2]);
        addUniqueEdge(edges, seen, facets[i][2], facets[i][0]);
    }
    var bands = speakerBands();
    for (var b = 0; b < bands.length; b++) {
        if (bands[b].length > 2) {
            for (var j = 0; j < bands[b].length; j++) addUniqueEdge(edges, seen, bands[b][j].id, bands[b][(j + 1) % bands[b].length].id);
        }
    }
    return edges;
}

function addUniqueEdge(edges, seen, a, b) {
    var lo = Math.min(a, b);
    var hi = Math.max(a, b);
    var key = lo + ":" + hi;
    if (!seen[key]) {
        edges.push([a, b]);
        seen[key] = 1;
    }
}

function projectedById(projected) {
    var byId = {};
    for (var i = 0; i < projected.length; i++) byId[projected[i].id] = projected[i];
    return byId;
}

function azKey(az) {
    var key = Number(az);
    return key < 0 ? key + 360 : key;
}

function speakerAz(id) {
    for (var i = 0; i < activeSpeakers; i++) if (speakers[i].id == id) return speakers[i].az;
    return 0;
}

function wrapSignedDeg(v) {
    v = Number(v);
    while (v <= -180) v += 360;
    while (v > 180) v -= 360;
    return v;
}

function rotatePoint(p) {
    var cy = Math.cos(viewYaw);
    var sy = Math.sin(viewYaw);
    var x = p[0] * cy + p[1] * sy;
    var depth = -p[0] * sy + p[1] * cy;
    var height = p[2] * domeHeight();
    return [x, depth * planeSquash() + height, depth];
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

function scalePoint(p, amount) {
    return [p[0] * amount, p[1] * amount, p[2] * amount];
}

function distanceProjection(distance) {
    var d = Math.max(0, Number(distance));
    if (d <= 1) return d;
    return 1 + (d - 1) * 0.55;
}

function sourceDotSize(distance) {
    var d = Math.max(0.1, Number(distance));
    if (d < 1) return 3.2 + d * 4.8;
    return Math.max(3.6, 8 / Math.sqrt(d));
}

function sourceAedColor(azDeg, elDeg, distance, selected) {
    var hue = positiveModulo(Number(azDeg) / 360, 1);
    var light = clamp((clamp(Number(elDeg), -90, 90) + 90) / 180, 0.30, 0.86);
    var chroma = clamp(Number(distance) / 2.6, 0.08, 1.0) * 0.36;
    var a = Math.cos(hue * 2 * Math.PI) * chroma;
    var b = Math.sin(hue * 2 * Math.PI) * chroma;
    var l3 = light + 0.3963377774 * a + 0.2158037573 * b;
    var m3 = light - 0.1055613458 * a - 0.0638541728 * b;
    var s3 = light - 0.0894841775 * a - 1.2914855480 * b;
    var l = l3 * l3 * l3;
    var m = m3 * m3 * m3;
    var ss = s3 * s3 * s3;
    var r = linearToSrgb(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * ss);
    var g = linearToSrgb(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * ss);
    var bl = linearToSrgb(-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * ss);
    var grayMix = selected ? 0.06 : 0.18;
    return [
        r * (1 - grayMix) + 0.74 * grayMix,
        g * (1 - grayMix) + 0.74 * grayMix,
        bl * (1 - grayMix) + 0.74 * grayMix
    ];
}

function linearToSrgb(v) {
    var x = clamp(v, 0, 1);
    return x <= 0.0031308 ? x * 12.92 : 1.055 * Math.pow(x, 1 / 2.4) - 0.055;
}

function depthFront(z) {
    return 0.5 + (clamp((1 - z) * 0.5, 0, 1) - 0.5) * depthCueAmount();
}

function norm3(p) {
    var len = Math.sqrt(p[0] * p[0] + p[1] * p[1] + p[2] * p[2]);
    if (len <= 0) return [0, 0, 1];
    return [p[0] / len, p[1] / len, p[2] / len];
}

function dist3(a, b) {
    var dx = a[0] - b[0];
    var dy = a[1] - b[1];
    var dz = a[2] - b[2];
    return Math.sqrt(dx * dx + dy * dy + dz * dz);
}

function validNumber(value, fallback) {
    var n = Number(value);
    return isFinite(n) ? n : fallback;
}

function intOr(value, fallback) {
    var n = Math.round(Number(value));
    return isFinite(n) ? n : fallback;
}

function positiveModulo(value, length) {
    return ((value % length) + length) % length;
}

function wrapDeg(value) {
    var v = Number(value);
    while (v > 180) v -= 360;
    while (v <= -180) v += 360;
    return v;
}

function clamp(v, lo, hi) {
    return Math.max(lo, Math.min(hi, v));
}

function fmt(v) {
    v = Number(v);
    if (Math.abs(v) >= 10) return String(Math.round(v));
    return v.toFixed(2);
}

function set(r, g, b, a) {
    mgraphics.set_source_rgba(r, g, b, a);
}
