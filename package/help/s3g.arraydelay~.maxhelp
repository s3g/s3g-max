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
        "rect": [ 180.0, 180.0, 820.0, 560.0 ],
        "boxes": [
            { "box": { "id": "title", "maxclass": "comment", "patching_rect": [ 30.0, 20.0, 360.0, 20.0 ], "text": "s3g.arraydelay~ - speaker calibration delay" } },
            { "box": { "id": "sig", "maxclass": "newobj", "numinlets": 2, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 30.0, 60.0, 72.0, 22.0 ], "text": "cycle~ 440" } },
            { "box": { "id": "obj", "maxclass": "newobj", "numinlets": 6, "numoutlets": 7, "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "" ], "patching_rect": [ 30.0, 120.0, 160.0, 22.0 ], "text": "s3g.arraydelay~ 6" } },
            { "box": { "id": "gain", "maxclass": "newobj", "numinlets": 2, "numoutlets": 1, "outlettype": [ "signal" ], "patching_rect": [ 30.0, 170.0, 55.0, 22.0 ], "text": "*~ 0.1" } },
            { "box": { "id": "ezdac", "maxclass": "ezdac~", "numinlets": 2, "numoutlets": 0, "patching_rect": [ 30.0, 220.0, 45.0, 45.0 ] } },
            { "box": { "id": "delay1", "maxclass": "message", "numinlets": 2, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 250.0, 80.0, 90.0, 22.0 ], "text": "delay 1 2.5" } },
            { "box": { "id": "delays", "maxclass": "message", "numinlets": 2, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 350.0, 80.0, 200.0, 22.0 ], "text": "delays 0 1.25 2.5 3.75 0 0" } },
            { "box": { "id": "clear", "maxclass": "message", "numinlets": 2, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 565.0, 80.0, 140.0, 22.0 ], "text": "delays 0 0 0 0 0 0" } },
            { "box": { "id": "dump", "maxclass": "message", "numinlets": 2, "numoutlets": 1, "outlettype": [ "" ], "patching_rect": [ 250.0, 115.0, 45.0, 22.0 ], "text": "dump" } },
            { "box": { "id": "print", "maxclass": "newobj", "numinlets": 1, "numoutlets": 0, "patching_rect": [ 210.0, 170.0, 118.0, 22.0 ], "text": "print s3g.arraydelay" } },
            { "box": { "id": "a-active", "maxclass": "attrui", "attr": "activechannels", "patching_rect": [ 250.0, 210.0, 190.0, 22.0 ] } },
            { "box": { "id": "a-selected", "maxclass": "attrui", "attr": "selected", "patching_rect": [ 250.0, 240.0, 190.0, 22.0 ] } },
            { "box": { "id": "a-delay", "maxclass": "attrui", "attr": "delayms", "patching_rect": [ 250.0, 270.0, 190.0, 22.0 ] } },
            { "box": { "id": "a-max", "maxclass": "attrui", "attr": "maxdelay", "patching_rect": [ 250.0, 300.0, 190.0, 22.0 ] } },
            { "box": { "id": "a-output", "maxclass": "attrui", "attr": "output", "patching_rect": [ 250.0, 330.0, 190.0, 22.0 ] } },
            { "box": { "id": "a-bypass", "maxclass": "attrui", "attr": "bypass", "patching_rect": [ 250.0, 360.0, 190.0, 22.0 ] } },
            { "box": { "id": "mc", "maxclass": "newobj", "numinlets": 1, "numoutlets": 2, "outlettype": [ "multichannelsignal", "" ], "patching_rect": [ 480.0, 210.0, 210.0, 22.0 ], "text": "s3g.arraydelay~ 25 @mc 1" } },
            { "box": { "id": "note", "maxclass": "comment", "patching_rect": [ 480.0, 245.0, 280.0, 48.0 ], "text": "Use delays <list> to paste speaker calibration values in channel order." } }
        ],
        "lines": [
            { "patchline": { "source": [ "sig", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "sig", 0 ], "destination": [ "obj", 1 ] } },
            { "patchline": { "source": [ "sig", 0 ], "destination": [ "obj", 2 ] } },
            { "patchline": { "source": [ "delay1", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "delays", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "clear", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "dump", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "a-active", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "a-selected", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "a-delay", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "a-max", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "a-output", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "a-bypass", 0 ], "destination": [ "obj", 0 ] } },
            { "patchline": { "source": [ "obj", 0 ], "destination": [ "gain", 0 ] } },
            { "patchline": { "source": [ "gain", 0 ], "destination": [ "ezdac", 0 ] } },
            { "patchline": { "source": [ "gain", 0 ], "destination": [ "ezdac", 1 ] } },
            { "patchline": { "source": [ "obj", 6 ], "destination": [ "print", 0 ] } }
        ]
    }
}
