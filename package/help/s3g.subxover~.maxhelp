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
            100,
            100,
            1120,
            720
        ],
        "boxes": [
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        24,
                        620,
                        20
                    ],
                    "text": "s3g.subxover~: multichannel sub crossover / low-frequency send before s3g.layoutpan~"
                }
            },
            {
                "box": {
                    "id": "note",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        48,
                        720,
                        20
                    ],
                    "text": "Right outlet dumps state to the v8ui. Audio outlets remain fixed-width signal channels."
                }
            },
            {
                "box": {
                    "id": "v8",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "filename": "s3g_subxover_v8ui.js",
                    "patching_rect": [
                        520,
                        86,
                        540,
                        340
                    ],
                    "saved_object_attributes": {
                        "filename": "s3g_subxover_v8ui.js"
                    }
                }
            },
            {
                "box": {
                    "id": "obj",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 13,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        520,
                        470,
                        245,
                        22
                    ],
                    "text": "s3g.subxover~ 12 quad"
                }
            },
            {
                "box": {
                    "id": "print",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        790,
                        470,
                        125,
                        22
                    ],
                    "text": "print s3g.subxover"
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
                        30,
                        88,
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
                        104,
                        88,
                        48,
                        22
                    ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "layout-menu",
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30,
                        138,
                        150,
                        22
                    ],
                    "items": [
                        "cube8",
                        ",",
                        "cube17",
                        ",",
                        "custom",
                        ",",
                        "dodeca12",
                        ",",
                        "dome24",
                        ",",
                        "dome25",
                        ",",
                        "double16",
                        ",",
                        "double20",
                        ",",
                        "icosahedron20",
                        ",",
                        "octo",
                        ",",
                        "quad",
                        ",",
                        "quad+oh",
                        ",",
                        "ring12",
                        ",",
                        "ring16",
                        ",",
                        "5.0",
                        ",",
                        "5.0.2",
                        ",",
                        "5.0.4",
                        ",",
                        "6.0",
                        ",",
                        "7.0",
                        ",",
                        "7.0.2",
                        ",",
                        "7.0.4",
                        ",",
                        "7.0.6",
                        ",",
                        "9.0",
                        ",",
                        "9.0.2",
                        ",",
                        "9.0.4",
                        ",",
                        "9.0.6",
                        ",",
                        "11.0.8"
                    ]
                }
            },
            {
                "box": {
                    "id": "prepend-layout",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        198,
                        138,
                        92,
                        22
                    ],
                    "text": "prepend layout"
                }
            },
            {
                "box": {
                    "id": "mode-menu",
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30,
                        170,
                        92,
                        22
                    ],
                    "items": [
                        "split",
                        ",",
                        "send"
                    ]
                }
            },
            {
                "box": {
                    "id": "prepend-mode",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        138,
                        170,
                        86,
                        22
                    ],
                    "text": "prepend mode"
                }
            },
            {
                "box": {
                    "id": "msg-high",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        220,
                        110,
                        22
                    ],
                    "text": "highchannels 7"
                }
            },
            {
                "box": {
                    "id": "msg-subs",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        154,
                        220,
                        88,
                        22
                    ],
                    "text": "subcount 2"
                }
            },
            {
                "box": {
                    "id": "msg-offset",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        256,
                        220,
                        92,
                        22
                    ],
                    "text": "suboffset 8"
                }
            },
            {
                "box": {
                    "id": "msg-cutoff",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        252,
                        82,
                        22
                    ],
                    "text": "cutoff 80"
                }
            },
            {
                "box": {
                    "id": "msg-focus",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        126,
                        252,
                        100,
                        22
                    ],
                    "text": "subfocus 3"
                }
            },
            {
                "box": {
                    "id": "msg-subgain",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        240,
                        252,
                        92,
                        22
                    ],
                    "text": "subgain -3"
                }
            },
            {
                "box": {
                    "id": "msg-highgain",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        346,
                        252,
                        96,
                        22
                    ],
                    "text": "highgain -1"
                }
            },
            {
                "box": {
                    "id": "msg-bypass0",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        284,
                        72,
                        22
                    ],
                    "text": "bypass 0"
                }
            },
            {
                "box": {
                    "id": "msg-bypass1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        116,
                        284,
                        72,
                        22
                    ],
                    "text": "bypass 1"
                }
            },
            {
                "box": {
                    "id": "msg-fold",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        202,
                        284,
                        108,
                        22
                    ],
                    "text": "foldbypass 1"
                }
            },
            {
                "box": {
                    "id": "attr-layout",
                    "attr": "layout",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        340,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-mode",
                    "attr": "mode",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220,
                        340,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-high",
                    "attr": "highchannels",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        372,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-subs",
                    "attr": "subcount",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220,
                        372,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-offset",
                    "attr": "suboffset",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        404,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-cutoff",
                    "attr": "cutoff",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220,
                        404,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-focus",
                    "attr": "subfocus",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        436,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-subgain",
                    "attr": "subgain",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220,
                        436,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-highgain",
                    "attr": "highgain",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        468,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-bypass",
                    "attr": "bypass",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220,
                        468,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "id": "attr-fold",
                    "attr": "foldbypass",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        500,
                        170,
                        22
                    ],
                    "parameter_enable": 0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "loadbang",
                        0
                    ],
                    "destination": [
                        "dump",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "dump",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj",
                        12
                    ],
                    "destination": [
                        "v8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj",
                        12
                    ],
                    "destination": [
                        "print",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "layout-menu",
                        1
                    ],
                    "destination": [
                        "prepend-layout",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "prepend-layout",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "mode-menu",
                        1
                    ],
                    "destination": [
                        "prepend-mode",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "prepend-mode",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-high",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-subs",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-offset",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-cutoff",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-focus",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-subgain",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-highgain",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-bypass0",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-bypass1",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "msg-fold",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-layout",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-mode",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-high",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-subs",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-offset",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-cutoff",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-focus",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-subgain",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-highgain",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-bypass",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "attr-fold",
                        0
                    ],
                    "destination": [
                        "obj",
                        0
                    ]
                }
            }
        ]
    }
}
