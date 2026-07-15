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
        "rect": [ 431.0, 207.0, 849.0, 598.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 469.0, 54.0, 22.0 ],
                    "text": "mc.dac~"
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "lastchannelcount": 0,
                    "maxclass": "mc.live.gain~",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "multichannelsignal", "", "float", "list" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 30.0, 306.0, 48.0, 136.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "mc.live.gain~",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "mc.live.gain~",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "mc.live.gain~"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 30.0, 260.0, 219.0, 22.0 ],
                    "text": "s3g.ambidecoder~ 3 6 quad+oh @mc 1"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 515.0, 363.0, 20.0 ],
                    "text": "Patch output to an MC decoder and mc.dac~ after loading a buffer."
                }
            },
            {
                "box": {
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 430.0, 20.0 ],
                    "text": "s3g.ambigrain~ - buffer-backed ambisonic grain processor"
                }
            },
            {
                "box": {
                    "id": "note",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 45.0, 520.0, 20.0 ],
                    "text": "Load multichannel ACN/SN3D audio into buffer~, then refresh the object snapshot."
                }
            },
            {
                "box": {
                    "id": "replace",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 82.0, 62.0, 22.0 ],
                    "text": "replace"
                }
            },
            {
                "box": {
                    "id": "buf",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 115.0, 82.0, 170.0, 22.0 ],
                    "text": "buffer~ s3g_ambigrain_src"
                }
            },
            {
                "box": {
                    "id": "refresh",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 125.0, 58.0, 22.0 ],
                    "text": "refresh"
                }
            },
            {
                "box": {
                    "id": "dump",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 102.0, 125.0, 45.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "start",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 162.0, 125.0, 48.0, 22.0 ],
                    "text": "play 1"
                }
            },
            {
                "box": {
                    "id": "stop",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 224.0, 125.0, 48.0, 22.0 ],
                    "text": "play 0"
                }
            },
            {
                "box": {
                    "id": "obj",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 30.0, 172.0, 446.0, 22.0 ],
                    "text": "s3g.ambigrain~ s3g_ambigrain_src 3 @density 28 @grain 90 @output -12 @mc 1"
                }
            },
            {
                "box": {
                    "id": "print",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 540.0, 172.0, 130.0, 22.0 ],
                    "text": "print s3g.ambigrain"
                }
            },
            {
                "box": {
                    "attr": "buffer",
                    "id": "attrbuffer",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 82.0, 210.0, 22.0 ]
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
                    "patching_rect": [ 330.0, 120.0, 210.0, 22.0 ]
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
                    "patching_rect": [ 330.0, 150.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "density",
                    "id": "attrdensity",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 225.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "grain",
                    "id": "attrgrain",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 255.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "position",
                    "id": "attrposition",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 285.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "scan",
                    "id": "attrscan",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 315.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "jitter",
                    "id": "attrjitter",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 345.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "rate",
                    "id": "attrrate",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 570.0, 225.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "ratejitter",
                    "id": "attrratejit",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 570.0, 255.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "reverse",
                    "id": "attrreverse",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 570.0, 285.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "freeze",
                    "id": "attrfreeze",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 570.0, 315.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "jumpsteps",
                    "id": "attrjump",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 570.0, 345.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "sync",
                    "id": "attrsync",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 390.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "envelope",
                    "id": "attrenv",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 420.0, 210.0, 22.0 ]
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
                    "patching_rect": [ 330.0, 450.0, 210.0, 22.0 ]
                }
            },
            {
                "box": {
                    "attr": "play",
                    "id": "attrplay",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 480.0, 210.0, 22.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrbuffer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrdensity", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrenv", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrfreeze", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrgrain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrjitter", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrjump", 0 ]
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
                    "source": [ "attrplay", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrposition", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrrate", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrratejit", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrreverse", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrscan", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "attrsync", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "refresh", 0 ],
                    "source": [ "buf", 1 ]
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
                    "destination": [ "obj-5", 0 ],
                    "source": [ "obj", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "refresh", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "buf", 0 ],
                    "source": [ "replace", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "start", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj", 0 ],
                    "source": [ "stop", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-6": [ "mc.live.gain~", "mc.live.gain~", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "toolbaradditions": [ "Data Knot", "Vizzie" ]
    }
}