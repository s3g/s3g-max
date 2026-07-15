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
        "rect": [ 120.0, 120.0, 760.0, 520.0 ],
        "boxes": [
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 390.0, 20.0 ],
                    "text": "s3g.arrayhpf~ - post-decoder highpass for main arrays"
                }
            },
            {
                "box": {
                    "id": "noise",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 60.0, 55.0, 22.0 ],
                    "text": "noise~"
                }
            },
            {
                "box": {
                    "id": "sig2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 105.0, 60.0, 70.0, 22.0 ],
                    "text": "cycle~ 45"
                }
            },
            {
                "box": {
                    "id": "sig3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 195.0, 60.0, 85.0, 22.0 ],
                    "text": "cycle~ 1200"
                }
            },
            {
                "box": {
                    "id": "sig4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 300.0, 60.0, 85.0, 22.0 ],
                    "text": "cycle~ 2200"
                }
            },
            {
                "box": {
                    "id": "obj",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 5,
                    "outlettype": [ "signal", "signal", "signal", "signal", "" ],
                    "patching_rect": [ 30.0, 130.0, 250.0, 22.0 ],
                    "text": "s3g.arrayhpf~ 4 @cutoff 90 @poles 2"
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
                    "text": "*~ 0.15"
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
                    "id": "polemsg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 400.0, 165.0, 60.0, 22.0 ],
                    "text": "poles 4"
                }
            },
            {
                "box": {
                    "id": "bypassmsg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 475.0, 165.0, 70.0, 22.0 ],
                    "text": "bypass 1"
                }
            },
            {
                "box": {
                    "id": "runmsg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 560.0, 165.0, 70.0, 22.0 ],
                    "text": "bypass 0"
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
                    "patching_rect": [ 310.0, 205.0, 180.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "poles",
                    "id": "attrpoles",
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
                    "attr": "activechannels",
                    "id": "attractive",
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
                    "attr": "output",
                    "id": "attrout",
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
                    "attr": "bypass",
                    "id": "attrbypass",
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
                    "filename": "s3g_arrayhpf_v8ui.js",
                    "id": "ui",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 37.0, 383.0, 430.0, 175.0 ],
                    "textfile": {
                        "filename": "s3g_arrayhpf_v8ui.js",
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
                    "patching_rect": [ 510.0, 410.0, 170.0, 22.0 ],
                    "text": "s3g.arrayhpf~ 16 @mc 1"
                }
            },
            {
                "box": {
                    "id": "mcc",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 510.0, 440.0, 210.0, 20.0 ],
                    "text": "MC form: one MC inlet, one MC outlet"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attractive", 0 ]
                }
            },
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
                    "source": [ "attrout", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrpoles", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "bypassmsg", 0 ]
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
                    "destination": [ "obj", 0 ],
                    "source": [ "noise", 0 ]
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
                    "source": [ "obj", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "polemsg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "runmsg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 1 ],
                    "source": [ "sig2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 2 ],
                    "source": [ "sig3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 3 ],
                    "source": [ "sig4", 0 ]
                }
            }
        ],
        "autosave": 0,
        "toolbaradditions": [ "Data Knot", "Vizzie" ]
    }
}