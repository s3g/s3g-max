{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 4,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            160,
            160,
            942,
            700
        ],
        "boxes": [
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        170,
                        392,
                        53,
                        22
                    ],
                    "text": "view top"
                }
            },
            {
                "box": {
                    "id": "viewside",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        235,
                        392,
                        58,
                        22
                    ],
                    "text": "view side"
                }
            },
            {
                "box": {
                    "id": "viewiso",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        305,
                        392,
                        52,
                        22
                    ],
                    "text": "view iso"
                }
            },
            {
                "box": {
                    "id": "zoomwide",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        370,
                        392,
                        60,
                        22
                    ],
                    "text": "zoom 0.8"
                }
            },
            {
                "box": {
                    "id": "zoomtight",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        440,
                        392,
                        65,
                        22
                    ],
                    "text": "zoom 1.35"
                }
            },
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        20,
                        360,
                        20
                    ],
                    "text": "s3g.ambidecoder~ - ambisonic speaker decoder"
                }
            },
            {
                "box": {
                    "id": "w",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        60,
                        220,
                        22
                    ],
                    "text": "Audio source omitted for DSP-safe help loading."
                }
            },
            {
                "box": {
                    "id": "y",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        85,
                        255,
                        22
                    ],
                    "text": "Patch ambisonic signals into the decoder manually."
                }
            },
            {
                "box": {
                    "id": "x",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        110,
                        260,
                        22
                    ],
                    "text": "Output can be sent to gain~ / dac~ in a test patch."
                }
            },
            {
                "box": {
                    "id": "obj",
                    "maxclass": "newobj",
                    "numinlets": 16,
                    "numoutlets": 7,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        30,
                        130,
                        220,
                        22
                    ],
                    "text": "s3g.ambidecoder~ 3 6 quad+oh"
                }
            },
            {
                "box": {
                    "id": "gain",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        185,
                        260,
                        22
                    ],
                    "text": "Signal output stage omitted from help patch."
                }
            },
            {
                "box": {
                    "id": "ezdac",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        230,
                        260,
                        22
                    ],
                    "text": "Use ezdac~ or mc.dac~ in a separate audio test."
                }
            },
            {
                "box": {
                    "id": "loadbang",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        300,
                        100,
                        60,
                        22
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "dump",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300,
                        130,
                        45,
                        22
                    ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "quad",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300,
                        165,
                        95,
                        22
                    ],
                    "text": "layout quad+oh"
                }
            },
            {
                "box": {
                    "id": "sphere",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        410,
                        165,
                        105,
                        22
                    ],
                    "text": "layout sphere24"
                }
            },
            {
                "box": {
                    "id": "speaker",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        530,
                        165,
                        135,
                        22
                    ],
                    "text": "speaker 1 -30 0 1 1"
                }
            },
            {
                "box": {
                    "id": "gainslist",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        680,
                        165,
                        180,
                        22
                    ],
                    "text": "gains 1 1 1 1 0.7 0.7"
                }
            },
            {
                "box": {
                    "attr": "layout",
                    "id": "attrlayout",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300,
                        205,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "mode",
                    "id": "attrmode",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300,
                        265,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "weighting",
                    "id": "attrweight",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300,
                        295,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "width",
                    "id": "attrwidth",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300,
                        325,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "energy",
                    "id": "attrenergy",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300,
                        355,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "output",
                    "id": "attrout",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300,
                        385,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "selected",
                    "id": "attrsel",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        520,
                        205,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "azimuth",
                    "id": "attraz",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        520,
                        235,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "elevation",
                    "id": "attrel",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        520,
                        265,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "distance",
                    "id": "attrdist",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        520,
                        295,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "attr": "speakergain",
                    "id": "attrgain",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        520,
                        325,
                        190,
                        22
                    ]
                }
            },
            {
                "box": {
                    "filename": "s3g_ambidecoder_v8ui.js",
                    "id": "ui",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "parameter_enable": 0,
                    "patching_rect": [
                        45,
                        465,
                        430,
                        190
                    ],
                    "textfile": {
                        "filename": "s3g_ambidecoder_v8ui.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "mc",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        520,
                        455,
                        250,
                        22
                    ],
                    "text": "MC form: s3g.ambidecoder~ 3 24 sphere24 @mc 1"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attraz",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrdist",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrenergy",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrgain",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrlayout",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrmode",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrout",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrsel",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrweight",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "attrwidth",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "dump",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "dump",
                        0
                    ],
                    "source": [
                        "loadbang",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "ui",
                        0
                    ],
                    "source": [
                        "obj",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "ui",
                        0
                    ],
                    "source": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "ui",
                        0
                    ],
                    "source": [
                        "viewside",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "ui",
                        0
                    ],
                    "source": [
                        "viewiso",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "ui",
                        0
                    ],
                    "source": [
                        "zoomwide",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "ui",
                        0
                    ],
                    "source": [
                        "zoomtight",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "quad",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "speaker",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "gainslist",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj",
                        0
                    ],
                    "source": [
                        "sphere",
                        0
                    ]
                }
            }
        ],
        "autosave": 0,
        "toolbaradditions": [
            "Data Knot",
            "Vizzie"
        ]
    }
}
