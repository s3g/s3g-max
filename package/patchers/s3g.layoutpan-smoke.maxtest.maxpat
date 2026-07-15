{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 8,
      "minor": 6,
      "revision": 5,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [120.0, 120.0, 760.0, 520.0],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "gridonopen": 1,
    "gridsize": [15.0, 15.0],
    "gridsnaponopen": 1,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 1,
    "boxes": [
      {
        "box": {
          "id": "obj-comment",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [30.0, 20.0, 560.0, 20.0],
          "text": "s3g.layoutpan~ Max-host smoke test: layout state and non-silent audio"
        }
      },
      {
        "box": {
          "id": "obj-loadbang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": ["bang"],
          "patching_rect": [30.0, 60.0, 60.0, 20.0],
          "text": "loadbang"
        }
      },
      {
        "box": {
          "id": "obj-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 6,
          "outlettype": ["bang", "bang", "bang", "bang", "bang", "bang"],
          "patching_rect": [30.0, 95.0, 104.0, 20.0],
          "text": "t b b b b b b"
        }
      },
      {
        "box": {
          "id": "obj-dac-on",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [30.0, 135.0, 30.0, 20.0],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "obj-dac",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [30.0, 170.0, 40.0, 20.0],
          "text": "dac~"
        }
      },
      {
        "box": {
          "id": "obj-output-msg",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [120.0, 135.0, 58.0, 20.0],
          "text": "output 0"
        }
      },
      {
        "box": {
          "id": "obj-method-msg",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [190.0, 135.0, 70.0, 20.0],
          "text": "method dist"
        }
      },
      {
        "box": {
          "id": "obj-source1-msg",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [275.0, 135.0, 130.0, 20.0],
          "text": "source 1 -45 0 1 0"
        }
      },
      {
        "box": {
          "id": "obj-source2-msg",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [420.0, 135.0, 130.0, 20.0],
          "text": "source 2 45 0 1 0"
        }
      },
      {
        "box": {
          "id": "obj-dump-msg",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [565.0, 135.0, 40.0, 20.0],
          "text": "dump"
        }
      },
      {
        "box": {
          "id": "obj-sig1",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": ["signal"],
          "patching_rect": [120.0, 200.0, 60.0, 20.0],
          "text": "sig~ 0.5"
        }
      },
      {
        "box": {
          "id": "obj-sig2",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": ["signal"],
          "patching_rect": [200.0, 200.0, 66.0, 20.0],
          "text": "sig~ 0.25"
        }
      },
      {
        "box": {
          "id": "obj-layoutpan",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 7,
          "outlettype": ["signal", "signal", "signal", "signal", "signal", "signal", ""],
          "patching_rect": [120.0, 250.0, 195.0, 20.0],
          "text": "s3g.layoutpan~ 2 6 quad+oh"
        }
      },
      {
        "box": {
          "id": "obj-sample",
          "color": [1.0, 0.66, 0.0, 1.0],
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [120.0, 300.0, 78.0, 20.0],
          "text": "test.sample~"
        }
      },
      {
        "box": {
          "id": "obj-sample-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": ["bang", "bang", "float"],
          "patching_rect": [120.0, 330.0, 34.0, 20.0],
          "text": "t b b f"
        }
      },
      {
        "box": {
          "id": "obj-dac-off",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [30.0, 420.0, 30.0, 20.0],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "obj-sample-num",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["", "bang"],
          "patching_rect": [175.0, 335.0, 80.0, 20.0],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "id": "obj-nonzero",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [120.0, 370.0, 124.0, 20.0],
          "text": "expr abs($f1) > 0.000001"
        }
      },
      {
        "box": {
          "id": "obj-nonzero-assert",
          "color": [1.0, 0.66, 0.0, 1.0],
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [120.0, 405.0, 180.0, 20.0],
          "text": "test.assert audio-output-nonzero"
        }
      },
      {
        "box": {
          "id": "obj-route",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "outlettype": ["", "", "", ""],
          "patching_rect": [365.0, 300.0, 170.0, 20.0],
          "text": "route layout config done"
        }
      },
      {
        "box": {
          "id": "obj-layout-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["int", ""],
          "patching_rect": [365.0, 335.0, 62.0, 20.0],
          "text": "unpack i s"
        }
      },
      {
        "box": {
          "id": "obj-layout-sel",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": ["bang", ""],
          "patching_rect": [400.0, 370.0, 75.0, 20.0],
          "text": "sel quad+oh"
        }
      },
      {
        "box": {
          "id": "obj-layout-one",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [400.0, 405.0, 30.0, 20.0],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "obj-layout-assert",
          "color": [1.0, 0.66, 0.0, 1.0],
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [400.0, 440.0, 188.0, 20.0],
          "text": "test.assert reports-quad-oh"
        }
      },
      {
        "box": {
          "id": "obj-config-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": ["int", "int", "int"],
          "patching_rect": [525.0, 335.0, 72.0, 20.0],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-config-pack",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [525.0, 370.0, 60.0, 20.0],
          "text": "pack i i i"
        }
      },
      {
        "box": {
          "id": "obj-config-match",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": ["bang", ""],
          "patching_rect": [525.0, 405.0, 72.0, 20.0],
          "text": "match 2 6 6"
        }
      },
      {
        "box": {
          "id": "obj-config-one",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [525.0, 440.0, 30.0, 20.0],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "obj-config-assert",
          "color": [1.0, 0.66, 0.0, 1.0],
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [525.0, 475.0, 172.0, 20.0],
          "text": "test.assert config-2-6-6"
        }
      },
      {
        "box": {
          "id": "obj-terminate",
          "color": [1.0, 0.66, 0.0, 1.0],
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [30.0, 455.0, 92.0, 20.0],
          "text": "test.terminate"
        }
      }
    ],
    "lines": [
      { "patchline": { "source": ["obj-loadbang", 0], "destination": ["obj-trigger", 0] } },
      { "patchline": { "source": ["obj-trigger", 0], "destination": ["obj-dump-msg", 0] } },
      { "patchline": { "source": ["obj-trigger", 1], "destination": ["obj-source2-msg", 0] } },
      { "patchline": { "source": ["obj-trigger", 2], "destination": ["obj-source1-msg", 0] } },
      { "patchline": { "source": ["obj-trigger", 3], "destination": ["obj-method-msg", 0] } },
      { "patchline": { "source": ["obj-trigger", 4], "destination": ["obj-output-msg", 0] } },
      { "patchline": { "source": ["obj-trigger", 5], "destination": ["obj-dac-on", 0] } },
      { "patchline": { "source": ["obj-dac-on", 0], "destination": ["obj-dac", 0] } },
      { "patchline": { "source": ["obj-output-msg", 0], "destination": ["obj-layoutpan", 0] } },
      { "patchline": { "source": ["obj-method-msg", 0], "destination": ["obj-layoutpan", 0] } },
      { "patchline": { "source": ["obj-source1-msg", 0], "destination": ["obj-layoutpan", 0] } },
      { "patchline": { "source": ["obj-source2-msg", 0], "destination": ["obj-layoutpan", 0] } },
      { "patchline": { "source": ["obj-dump-msg", 0], "destination": ["obj-layoutpan", 0] } },
      { "patchline": { "source": ["obj-sig1", 0], "destination": ["obj-layoutpan", 0] } },
      { "patchline": { "source": ["obj-sig2", 0], "destination": ["obj-layoutpan", 1] } },
      { "patchline": { "source": ["obj-layoutpan", 0], "destination": ["obj-sample", 0] } },
      { "patchline": { "source": ["obj-layoutpan", 6], "destination": ["obj-route", 0] } },
      { "patchline": { "source": ["obj-sample", 0], "destination": ["obj-sample-trigger", 0] } },
      { "patchline": { "source": ["obj-sample-trigger", 0], "destination": ["obj-terminate", 0] } },
      { "patchline": { "source": ["obj-sample-trigger", 1], "destination": ["obj-dac-off", 0] } },
      { "patchline": { "source": ["obj-sample-trigger", 2], "destination": ["obj-sample-num", 0] } },
      { "patchline": { "source": ["obj-dac-off", 0], "destination": ["obj-dac", 0] } },
      { "patchline": { "source": ["obj-sample-num", 0], "destination": ["obj-nonzero", 0] } },
      { "patchline": { "source": ["obj-nonzero", 0], "destination": ["obj-nonzero-assert", 0] } },
      { "patchline": { "source": ["obj-route", 0], "destination": ["obj-layout-unpack", 0] } },
      { "patchline": { "source": ["obj-layout-unpack", 1], "destination": ["obj-layout-sel", 0] } },
      { "patchline": { "source": ["obj-layout-sel", 0], "destination": ["obj-layout-one", 0] } },
      { "patchline": { "source": ["obj-layout-one", 0], "destination": ["obj-layout-assert", 0] } },
      { "patchline": { "source": ["obj-route", 1], "destination": ["obj-config-unpack", 0] } },
      { "patchline": { "source": ["obj-config-unpack", 0], "destination": ["obj-config-pack", 0] } },
      { "patchline": { "source": ["obj-config-unpack", 1], "destination": ["obj-config-pack", 1] } },
      { "patchline": { "source": ["obj-config-unpack", 2], "destination": ["obj-config-pack", 2] } },
      { "patchline": { "source": ["obj-config-pack", 0], "destination": ["obj-config-match", 0] } },
      { "patchline": { "source": ["obj-config-match", 0], "destination": ["obj-config-one", 0] } },
      { "patchline": { "source": ["obj-config-one", 0], "destination": ["obj-config-assert", 0] } }
    ],
    "dependency_cache": [
      { "name": "oscar.mxo", "type": "iLaX" }
    ],
    "autosave": 0
  }
}
