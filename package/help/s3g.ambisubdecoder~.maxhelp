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
        "rect": [ 140.0, 140.0, 760.0, 520.0 ],
        "boxes": [
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 440.0, 20.0 ],
                    "text": "s3g.ambisubdecoder~ - ambisonic input to 1-8 directional sub feeds"
                }
            },
            {
                "box": {
                    "id": "w",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 60.0, 70.0, 22.0 ],
                    "text": "cycle~ 70"
                }
            },
            {
                "box": {
                    "id": "y",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 120.0, 60.0, 80.0, 22.0 ],
                    "text": "cycle~ 0.11"
                }
            },
            {
                "box": {
                    "id": "x",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 210.0, 60.0, 80.0, 22.0 ],
                    "text": "cycle~ 0.07"
                }
            },
            {
                "box": {
                    "id": "obj",
                    "maxclass": "newobj",
                    "numinlets": 16,
                    "numoutlets": 3,
                    "outlettype": [ "signal", "signal", "" ],
                    "patching_rect": [ 30.0, 130.0, 245.0, 22.0 ],
                    "text": "s3g.ambisubdecoder~ 3 2 @cutoff 90"
                }
            },
            {
                "box": {
                    "id": "gain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 185.0, 55.0, 22.0 ],
                    "text": "*~ 0.12"
                }
            },
            {
                "box": {
                    "id": "ezdac",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 230.0, 45.0, 45.0 ]
                }
            },
            {
                "box": {
                    "id": "dump",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 310.0, 130.0, 45.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "cutmsg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 310.0, 165.0, 75.0, 22.0 ],
                    "text": "cutoff 120"
                }
            },
            {
                "box": {
                    "id": "widthmsg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 400.0, 165.0, 75.0, 22.0 ],
                    "text": "width 1.3"
                }
            },
            {
                "box": {
                    "id": "submsg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 490.0, 165.0, 80.0, 22.0 ],
                    "text": "subcount 1"
                }
            },
            {
                "box": {
                    "id": "submsg2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 585.0, 165.0, 80.0, 22.0 ],
                    "text": "subcount 2"
                }
            },
            {
                "box": {
                    "attr": "order",
                    "id": "attrorder",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 310.0, 205.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "subcount",
                    "id": "attrsubs",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 310.0, 235.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "cutoff",
                    "id": "attrcut",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 310.0, 265.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "width",
                    "id": "attrwidth",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 310.0, 295.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "output",
                    "id": "attrout",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 310.0, 325.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "bypass",
                    "id": "attrbypass",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 310.0, 355.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "filename": "s3g_ambisubdecoder_v8ui.js",
                    "id": "ui",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 37.0, 407.0, 430.0, 175.0 ],
                    "textfile": {
                        "filename": "s3g_ambisubdecoder_v8ui.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "mc",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 510.0, 420.0, 210.0, 22.0 ],
                    "text": "s3g.ambisubdecoder~ 3 4 @mc 1"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrbypass", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrcut", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrorder", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrout", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrsubs", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrwidth", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "cutmsg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "dump", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ezdac", 1 ],
                    "order": 0,
                    "source": [ "gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ezdac", 0 ],
                    "order": 1,
                    "source": [ "gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "gain", 0 ],
                    "source": [ "obj", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "obj", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "submsg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "submsg2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "w", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "widthmsg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 3 ],
                    "source": [ "x", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 1 ],
                    "source": [ "y", 0 ]
                }
            }
        ],
        "autosave": 0,
        "toolbaradditions": [ "Data Knot", "Vizzie" ]
    }
}