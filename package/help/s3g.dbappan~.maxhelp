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
        "rect": [ 236.0, 318.0, 1450.0, 800.0 ],
        "showrootpatcherontab": 0,
        "showontab": 0,
        "boxes": [
            {
                "box": {
                    "id": "tab_0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 236.0, 344.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-2",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1029.0, 103.0, 83.0, 22.0 ],
                                    "text": "layout cube41"
                                }
                            },
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "V8UI layout browser - display-only messages"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1060.0, 20.0 ],
                                    "text": "This tab contains only s3g_layoutpan_v8ui.js. Choose a layout from the umenu or send direct V8UI messages."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_menu",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 26.0, 22.0 ],
                                    "text": "4"
                                }
                            },
                            {
                                "box": {
                                    "id": "menu_label",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 835.0, 122.0, 180.0, 20.0 ],
                                    "text": "Layout messages to V8UI"
                                }
                            },
                            {
                                "box": {
                                    "id": "menu",
                                    "items": [ "cube8", ",", "cube17", ",", "dodeca12", ",", "dome24", ",", "dome25", ",", "double16", ",", "double20", ",", "icosahedron20", ",", "octo", ",", "quad", ",", "quad+oh", ",", "ring12", ",", "ring16", ",", "5.0", ",", "5.0.2", ",", "5.0.4", ",", "6.0", ",", "7.0", ",", "7.0.2", ",", "7.0.4", ",", "7.0.6", ",", "9.0", ",", "9.0.2", ",", "9.0.4", ",", "9.0.6", ",", "11.0.8" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 835.0, 148.0, 180.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "sel",
                                    "maxclass": "newobj",
                                    "numinlets": 14,
                                    "numoutlets": 14,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "" ],
                                    "patching_rect": [ 1030.0, 148.0, 392.0, 22.0 ],
                                    "text": "sel 0 1 2 3 4 5 6 7 8 9 10 11 12"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_cube8_alt",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_cube8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 980.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_cube17",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout cube17"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_dodeca12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout dodeca12"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_dome24",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout dome24"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_dome25",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 980.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout dome25"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_double16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout double16"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_double20",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout double20"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_octo",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout octo"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_quad",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 980.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout quad"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_quadohoh",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout quad+oh"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_ring12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout ring12"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_ring16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 280.0, 132.0, 22.0 ],
                                    "text": "layout ring16"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_config",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 320.0, 132.0, 22.0 ],
                                    "text": "config 8 24 24"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_method_dist",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 975.0, 320.0, 84.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_method_cos",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1067.0, 320.0, 84.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_params",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 350.0, 250.0, 22.0 ],
                                    "text": "params 1.4 6 35 0 0 0 0.35 -6 3"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_source",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1093.0, 350.0, 205.0, 22.0 ],
                                    "text": "source 3 45 0 1.2 -3 0 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_speaker",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 380.0, 140.0, 22.0 ],
                                    "text": "speaker 1 -30 0 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 983.0, 380.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1061.0, 380.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_front",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1139.0, 380.0, 82.0, 22.0 ],
                                    "text": "view front"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_side",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1229.0, 380.0, 76.0, 22.0 ],
                                    "text": "view side"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_zoom",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1313.0, 380.0, 64.0, 22.0 ],
                                    "text": "zoom 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_zoomin",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 410.0, 86.0, 22.0 ],
                                    "text": "zoomin 1.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_zoomout",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 929.0, 410.0, 96.0, 22.0 ],
                                    "text": "zoomout 1.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_resetzoom",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1033.0, 410.0, 82.0, 22.0 ],
                                    "text": "resetzoom"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_bang",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1123.0, 410.0, 48.0, 22.0 ],
                                    "text": "bang"
                                }
                            },
                            {
                                "box": {
                                    "id": "wheel_note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 835.0, 650.0, 362.0, 20.0 ],
                                    "text": "Mouse wheel bridge: mousestate vertical wheel -> wheel message"
                                }
                            },
                            {
                                "box": {
                                    "id": "wheel_load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 676.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "wheel_mouse",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 10,
                                    "outlettype": [ "int", "int", "int", "int", "int", "int", "int", "float", "float", "list" ],
                                    "patching_rect": [ 835.0, 706.0, 82.0, 22.0 ],
                                    "text": "mousestate"
                                }
                            },
                            {
                                "box": {
                                    "id": "wheel_prepend",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 736.0, 92.0, 22.0 ],
                                    "text": "prepend wheel"
                                }
                            },
                            {
                                "box": {
                                    "id": "wheel_setup",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 912.0, 676.0, 104.0, 22.0 ],
                                    "text": "mode 1, poll"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "menu", 0 ],
                                    "source": [ "init_menu", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_cube17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_cube8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_cube8_alt", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_dodeca12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_dome24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_dome25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_double16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_double20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_octo", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_quad", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_quadohoh", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_ring12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "layout_ring16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_menu", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dome24", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "sel", 0 ],
                                    "source": [ "menu", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_bang", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_config", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_method_cos", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_method_dist", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_params", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_resetzoom", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_source", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_speaker", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_front", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_side", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_zoom", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_zoomin", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_zoomout", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_cube17", 0 ],
                                    "source": [ "sel", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_cube8", 0 ],
                                    "source": [ "sel", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_cube8_alt", 0 ],
                                    "source": [ "sel", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dodeca12", 0 ],
                                    "source": [ "sel", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dome24", 0 ],
                                    "source": [ "sel", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dome25", 0 ],
                                    "source": [ "sel", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_double16", 0 ],
                                    "source": [ "sel", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_double20", 0 ],
                                    "source": [ "sel", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_octo", 0 ],
                                    "source": [ "sel", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_quad", 0 ],
                                    "source": [ "sel", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_quadohoh", 0 ],
                                    "source": [ "sel", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_ring12", 0 ],
                                    "source": [ "sel", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_ring16", 0 ],
                                    "source": [ "sel", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "wheel_setup", 0 ],
                                    "source": [ "wheel_load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "wheel_prepend", 0 ],
                                    "source": [ "wheel_mouse", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "wheel_prepend", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "wheel_mouse", 0 ],
                                    "source": [ "wheel_setup", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 30.0, 30.0, 120.0, 22.0 ],
                    "text": "p v8ui-layouts"
                }
            },
            {
                "box": {
                    "id": "tab_1",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 880.0, 20.0 ],
                                    "text": "DBAP object layout browser - umenu drives s3g.dbappan~, object state drives V8UI"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1110.0, 20.0 ],
                                    "text": "This tab tests the full path: layout message -> s3g.dbappan~ -> config/layout/params/speaker/source dump -> V8UI."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_menu",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 26.0, 22.0 ],
                                    "text": "4"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 946.0, 82.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "menu_label",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 835.0, 122.0, 220.0, 20.0 ],
                                    "text": "Choose layout for s3g.dbappan~"
                                }
                            },
                            {
                                "box": {
                                    "id": "menu",
                                    "items": [ "cube8", ",", "cube17", ",", "dodeca12", ",", "dome24", ",", "dome25", ",", "double16", ",", "double20", ",", "icosahedron20", ",", "octo", ",", "quad", ",", "quad+oh", ",", "ring12", ",", "ring16", ",", "5.0", ",", "5.0.2", ",", "5.0.4", ",", "6.0", ",", "7.0", ",", "7.0.2", ",", "7.0.4", ",", "7.0.6", ",", "9.0", ",", "9.0.2", ",", "9.0.4", ",", "9.0.6", ",", "11.0.8" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 835.0, 148.0, 180.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "sel",
                                    "maxclass": "newobj",
                                    "numinlets": 14,
                                    "numoutlets": 14,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "" ],
                                    "patching_rect": [ 1030.0, 148.0, 392.0, 22.0 ],
                                    "text": "sel 0 1 2 3 4 5 6 7 8 9 10 11 12"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 265.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 265.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 65,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 305.0, 430.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 64 dome24"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 341.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 337.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 341.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_cube8_alt",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_cube8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 980.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_cube17",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout cube17"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_dodeca12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 190.0, 132.0, 22.0 ],
                                    "text": "layout dodeca12"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_dome24",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout dome24"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_dome25",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 980.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout dome25"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_double16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout double16"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_double20",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 220.0, 132.0, 22.0 ],
                                    "text": "layout double20"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_octo",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout octo"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_quad",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 980.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout quad"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_quadohoh",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout quad+oh"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_ring12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 250.0, 132.0, 22.0 ],
                                    "text": "layout ring12"
                                }
                            },
                            {
                                "box": {
                                    "id": "layout_ring16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 280.0, 132.0, 22.0 ],
                                    "text": "layout ring16"
                                }
                            },
                            {
                                "box": {
                                    "id": "m_method",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 402.0, 84.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "m_focus",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 927.0, 402.0, 84.0, 22.0 ],
                                    "text": "focus 1.65"
                                }
                            },
                            {
                                "box": {
                                    "id": "m_roll",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1019.0, 402.0, 88.0, 22.0 ],
                                    "text": "rolloff 12."
                                }
                            },
                            {
                                "box": {
                                    "id": "m_smooth",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1115.0, 402.0, 84.0, 22.0 ],
                                    "text": "smooth 60."
                                }
                            },
                            {
                                "box": {
                                    "id": "m_diff",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1207.0, 402.0, 108.0, 22.0 ],
                                    "text": "diffusion 0.55"
                                }
                            },
                            {
                                "box": {
                                    "id": "m_dump_alt",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1323.0, 402.0, 104.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "m_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1435.0, 402.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "attr": "layout",
                                    "id": "attr1",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 642.0, 170.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "diffusion",
                                    "id": "attr2",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 210.0, 642.0, 150.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "focus",
                                    "id": "attr3",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 370.0, 642.0, 150.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "selected",
                                    "id": "attr4",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 530.0, 642.0, 150.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "azimuth",
                                    "id": "attr5",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 690.0, 642.0, 150.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "elevation",
                                    "id": "attr6",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 850.0, 642.0, 150.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "distance",
                                    "id": "attr7",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1010.0, 642.0, 150.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "attr": "output",
                                    "id": "attr8",
                                    "maxclass": "attrui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1170.0, 642.0, 150.0, 22.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "attr8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "menu", 0 ],
                                    "source": [ "init_menu", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_cube17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_cube8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_cube8_alt", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_dodeca12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_dome24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_dome25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_double16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_double20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_octo", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_quad", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_quadohoh", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_ring12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "layout_ring16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_dump", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_menu", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_diff", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_focus", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_method", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_roll", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "m_smooth", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "sel", 0 ],
                                    "source": [ "menu", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 64 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 64 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_cube17", 0 ],
                                    "source": [ "sel", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_cube8", 0 ],
                                    "source": [ "sel", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_cube8_alt", 0 ],
                                    "source": [ "sel", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dodeca12", 0 ],
                                    "source": [ "sel", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dome24", 0 ],
                                    "source": [ "sel", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_dome25", 0 ],
                                    "source": [ "sel", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_double16", 0 ],
                                    "source": [ "sel", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_double20", 0 ],
                                    "source": [ "sel", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_octo", 0 ],
                                    "source": [ "sel", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_quad", 0 ],
                                    "source": [ "sel", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_quadohoh", 0 ],
                                    "source": [ "sel", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_ring12", 0 ],
                                    "source": [ "sel", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "layout_ring16", 0 ],
                                    "source": [ "sel", 12 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 165.0, 30.0, 120.0, 22.0 ],
                    "text": "p object-layouts"
                }
            },
            {
                "box": {
                    "id": "tab_2",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "cube8 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 9,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 192.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 8 cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 300.0, 30.0, 120.0, 22.0 ],
                    "text": "p cube8"
                }
            },
            {
                "box": {
                    "id": "tab_3",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "cube17 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout cube17"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 18,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 273.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 17 cube17"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 17 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 17 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 435.0, 30.0, 120.0, 22.0 ],
                    "text": "p cube17"
                }
            },
            {
                "box": {
                    "id": "tab_4",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "curated cube8 layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 17,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 264.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 8 cube8"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 570.0, 30.0, 120.0, 22.0 ],
                    "text": "p cube8"
                }
            },
            {
                "box": {
                    "id": "tab_5",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "dodeca12 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout dodeca12"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 13,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 228.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 12 dodeca12"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 705.0, 60.0, 120.0, 22.0 ],
                    "text": "p dodeca12"
                }
            },
            {
                "box": {
                    "id": "tab_6",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "dome24 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout dome24"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 25,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 336.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 24 dome24"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 24 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 24 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 30.0, 60.0, 120.0, 22.0 ],
                    "text": "p dome24"
                }
            },
            {
                "box": {
                    "id": "tab_7",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "dome25 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout dome25"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 26,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 345.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 25 dome25"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 25 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 25 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 165.0, 60.0, 120.0, 22.0 ],
                    "text": "p dome25"
                }
            },
            {
                "box": {
                    "id": "tab_8",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "double16 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout double16"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 17,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 264.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 16 double16"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 300.0, 60.0, 120.0, 22.0 ],
                    "text": "p double16"
                }
            },
            {
                "box": {
                    "id": "tab_9",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "double20 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout double20"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 21,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 300.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 20 double20"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 435.0, 60.0, 120.0, 22.0 ],
                    "text": "p double20"
                }
            },
            {
                "box": {
                    "id": "tab_10",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "icosahedron20 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 123.0, 22.0 ],
                                    "text": "layout icosahedron20"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 21,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 300.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 20 icosahedron20"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 570.0, 30.0, 150.0, 22.0 ],
                    "text": "p icosahedron20"
                }
            },
            {
                "box": {
                    "id": "tab_11",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "octo fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout octo"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 9,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 192.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 8 octo"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 705.0, 90.0, 120.0, 22.0 ],
                    "text": "p octo"
                }
            },
            {
                "box": {
                    "id": "tab_12",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "quad fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout quad"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 5,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 190.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 4 quad"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 30.0, 90.0, 120.0, 22.0 ],
                    "text": "p quad"
                }
            },
            {
                "box": {
                    "id": "tab_13",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "quad+oh fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout quad+oh"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 7,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 190.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 6 quad+oh"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 165.0, 90.0, 120.0, 22.0 ],
                    "text": "p quad+oh"
                }
            },
            {
                "box": {
                    "id": "tab_14",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "ring12 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout ring12"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 13,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 228.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 12 ring12"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 300.0, 90.0, 120.0, 22.0 ],
                    "text": "p ring12"
                }
            },
            {
                "box": {
                    "id": "tab_15",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "ring16 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout ring16"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 17,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 264.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 16 ring16"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 435.0, 90.0, 120.0, 22.0 ],
                    "text": "p ring16"
                }
            },
            {
                "box": {
                    "id": "tab_16",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "5.0 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 5."
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 6,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 280.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 5 5."
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 570.0, 90.0, 120.0, 22.0 ],
                    "text": "p 5."
                }
            },
            {
                "box": {
                    "id": "tab_17",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "5.0.2 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 5.0.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 8,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 290.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 7 5.0.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 705.0, 90.0, 120.0, 22.0 ],
                    "text": "p 5.0.2"
                }
            },
            {
                "box": {
                    "id": "tab_18",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "5.0.4 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 5.0.4"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 10,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 290.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 9 5.0.4"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 30.0, 90.0, 120.0, 22.0 ],
                    "text": "p 5.0.4"
                }
            },
            {
                "box": {
                    "id": "tab_19",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "6.0 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 6."
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 7,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 280.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 6 6."
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 165.0, 90.0, 120.0, 22.0 ],
                    "text": "p 6."
                }
            },
            {
                "box": {
                    "id": "tab_20",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "7.0 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 7."
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 8,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 280.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 7 7."
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 300.0, 90.0, 120.0, 22.0 ],
                    "text": "p 7."
                }
            },
            {
                "box": {
                    "id": "tab_21",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "7.0.2 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 7.0.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 10,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 290.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 9 7.0.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 435.0, 90.0, 120.0, 22.0 ],
                    "text": "p 7.0.2"
                }
            },
            {
                "box": {
                    "id": "tab_22",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "7.0.4 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 7.0.4"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 12,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 295.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 11 7.0.4"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 570.0, 90.0, 120.0, 22.0 ],
                    "text": "p 7.0.4"
                }
            },
            {
                "box": {
                    "id": "tab_23",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "7.0.6 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 7.0.6"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 14,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 295.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 13 7.0.6"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 705.0, 90.0, 120.0, 22.0 ],
                    "text": "p 7.0.6"
                }
            },
            {
                "box": {
                    "id": "tab_24",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "9.0 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 9."
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 10,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 280.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 9 9."
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 30.0, 90.0, 120.0, 22.0 ],
                    "text": "p 9."
                }
            },
            {
                "box": {
                    "id": "tab_25",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "9.0.2 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 9.0.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 12,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 295.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 11 9.0.2"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 165.0, 90.0, 120.0, 22.0 ],
                    "text": "p 9.0.2"
                }
            },
            {
                "box": {
                    "id": "tab_26",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "9.0.4 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 9.0.4"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 14,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 295.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 13 9.0.4"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 300.0, 90.0, 120.0, 22.0 ],
                    "text": "p 9.0.4"
                }
            },
            {
                "box": {
                    "id": "tab_27",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "9.0.6 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 9.0.6"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 16,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 295.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 15 9.0.6"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 435.0, 90.0, 120.0, 22.0 ],
                    "text": "p 9.0.6"
                }
            },
            {
                "box": {
                    "id": "tab_28",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1450.0, 774.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "title",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 18.0, 760.0, 20.0 ],
                                    "text": "11.0.8 fixed layout tab"
                                }
                            },
                            {
                                "box": {
                                    "id": "note",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 44.0, 1050.0, 20.0 ],
                                    "text": "Loadbang seeds the V8UI directly and then asks the matching s3g.dbappan~ object to dump its resolved speaker state."
                                }
                            },
                            {
                                "box": {
                                    "filename": "s3g_layoutpan_v8ui.js",
                                    "id": "v8",
                                    "maxclass": "v8ui",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "parameter_enable": 0,
                                    "patching_rect": [ 30.0, 82.0, 767.0, 520.0 ],
                                    "textfile": {
                                        "filename": "s3g_layoutpan_v8ui.js",
                                        "flags": 0,
                                        "embed": 0,
                                        "autowatch": 1
                                    }
                                }
                            },
                            {
                                "box": {
                                    "id": "load",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 835.0, 82.0, 64.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "id": "seed_v8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 82.0, 120.0, 22.0 ],
                                    "text": "layout 11.0.8"
                                }
                            },
                            {
                                "box": {
                                    "id": "init_obj",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1040.0, 82.0, 150.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "noise",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 835.0, 135.0, 54.0, 22.0 ],
                                    "text": "noise~"
                                }
                            },
                            {
                                "box": {
                                    "id": "gain",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 900.0, 135.0, 58.0, 22.0 ],
                                    "text": "*~ 0.08"
                                }
                            },
                            {
                                "box": {
                                    "id": "pan",
                                    "maxclass": "newobj",
                                    "numinlets": 8,
                                    "numoutlets": 20,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                                    "patching_rect": [ 835.0, 175.0, 300.0, 22.0 ],
                                    "text": "s3g.dbappan~ 8 19 11.0.8"
                                }
                            },
                            {
                                "box": {
                                    "id": "meter",
                                    "maxclass": "meter~",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 835.0, 211.0, 80.0, 13.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "dac",
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 928.0, 207.0, 45.0, 45.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "print",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1000.0, 211.0, 118.0, 22.0 ],
                                    "text": "print s3g.dbappan"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_dump",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 835.0, 275.0, 50.0, 22.0 ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_iso",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 895.0, 275.0, 70.0, 22.0 ],
                                    "text": "view iso"
                                }
                            },
                            {
                                "box": {
                                    "id": "msg_view_top",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 973.0, 275.0, 70.0, 22.0 ],
                                    "text": "view top"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "pan", 2 ],
                                    "order": 0,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 1 ],
                                    "order": 1,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "order": 2,
                                    "source": [ "gain", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "init_obj", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "init_obj", 0 ],
                                    "order": 0,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "seed_v8", 0 ],
                                    "order": 1,
                                    "source": [ "load", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "pan", 0 ],
                                    "source": [ "msg_dump", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_iso", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "msg_view_top", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "gain", 0 ],
                                    "source": [ "noise", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 1 ],
                                    "source": [ "pan", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "dac", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "meter", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "print", 0 ],
                                    "order": 0,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "order": 1,
                                    "source": [ "pan", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "v8", 0 ],
                                    "source": [ "seed_v8", 0 ]
                                }
                            }
                        ],
                        "toolbaradditions": [ "Data Knot", "Vizzie" ]
                    },
                    "patching_rect": [ 570.0, 90.0, 120.0, 22.0 ],
                    "text": "p 11.0.8"
                }
            }
        ],
        "lines": [],
        "autosave": 0,
        "toolbaradditions": [ "Data Knot", "Vizzie" ]
    }
}