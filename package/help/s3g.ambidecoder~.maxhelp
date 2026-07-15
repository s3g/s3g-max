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
        "rect": [ 160.0, 160.0, 942.0, 700.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 170.0, 392.0, 53.0, 22.0 ],
                    "text": "view top"
                }
            },
            {
                "box": {
                    "id": "viewside",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 235.0, 392.0, 58.0, 22.0 ],
                    "text": "view side"
                }
            },
            {
                "box": {
                    "id": "viewiso",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 305.0, 392.0, 52.0, 22.0 ],
                    "text": "view iso"
                }
            },
            {
                "box": {
                    "id": "zoomwide",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 370.0, 392.0, 60.0, 22.0 ],
                    "text": "zoom 0.8"
                }
            },
            {
                "box": {
                    "id": "zoomtight",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 440.0, 392.0, 65.0, 22.0 ],
                    "text": "zoom 1.35"
                }
            },
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 360.0, 20.0 ],
                    "text": "s3g.ambidecoder~ - ambisonic speaker decoder"
                }
            },
            {
                "box": {
                    "id": "w",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 60.0, 75.0, 22.0 ],
                    "text": "cycle~ 220"
                }
            },
            {
                "box": {
                    "id": "y",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 125.0, 60.0, 60.0, 22.0 ],
                    "text": "*~ 0.25"
                }
            },
            {
                "box": {
                    "id": "x",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 205.0, 60.0, 60.0, 22.0 ],
                    "text": "*~ 0.25"
                }
            },
            {
                "box": {
                    "id": "obj",
                    "maxclass": "newobj",
                    "numinlets": 16,
                    "numoutlets": 7,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                    "patching_rect": [ 30.0, 130.0, 220.0, 22.0 ],
                    "text": "s3g.ambidecoder~ 3 6 quad+oh"
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
                    "id": "loadbang",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 300.0, 100.0, 60.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "dump",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 300.0, 130.0, 45.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "quad",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 300.0, 165.0, 95.0, 22.0 ],
                    "text": "layout quad+oh"
                }
            },
            {
                "box": {
                    "id": "sphere",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 410.0, 165.0, 105.0, 22.0 ],
                    "text": "layout sphere24"
                }
            },
            {
                "box": {
                    "id": "speaker",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 530.0, 165.0, 135.0, 22.0 ],
                    "text": "speaker 1 -30 0 1 1"
                }
            },
            {
                "box": {
                    "attr": "layout",
                    "id": "attrlayout",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 300.0, 205.0, 190.0, 22.0 ]
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
                    "patching_rect": [ 300.0, 235.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "mode",
                    "id": "attrmode",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 300.0, 265.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "weighting",
                    "id": "attrweight",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 300.0, 295.0, 190.0, 22.0 ]
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
                    "patching_rect": [ 300.0, 325.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "energy",
                    "id": "attrenergy",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 300.0, 355.0, 190.0, 22.0 ]
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
                    "patching_rect": [ 300.0, 385.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "selected",
                    "id": "attrsel",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 520.0, 205.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "azimuth",
                    "id": "attraz",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 520.0, 235.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "elevation",
                    "id": "attrel",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 520.0, 265.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "distance",
                    "id": "attrdist",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 520.0, 295.0, 190.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "speakergain",
                    "id": "attrgain",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 520.0, 325.0, 190.0, 22.0 ]
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
                    "patching_rect": [ 45.0, 465.0, 430.0, 190.0 ],
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
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 520.0, 455.0, 250.0, 22.0 ],
                    "text": "s3g.ambidecoder~ 3 24 sphere24 @mc 1"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attraz", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrdist", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrenergy", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrgain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrlayout", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrmode", 0 ]
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
                    "source": [ "attrsel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrweight", 0 ]
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
                    "destination": [ "dump", 0 ],
                    "source": [ "loadbang", 0 ]
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
                    "source": [ "obj", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "viewside", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "viewiso", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "zoomwide", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "zoomtight", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "quad", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "speaker", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "sphere", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "order": 2,
                    "source": [ "w", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "x", 0 ],
                    "order": 0,
                    "source": [ "w", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "y", 0 ],
                    "order": 1,
                    "source": [ "w", 0 ]
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
