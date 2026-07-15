# s3g.layoutpan~ Design Notes

`s3g.layoutpan~` continues an earlier line of Max/RNBO spatial panner work, but
the current object is a native Max external built around the shared C++ DSP in
`s3g-dsp`.

## Display Model

The V8UI display keeps the familiar field-view language from the older Max
patches:

- dark neutral field
- draggable camera views
- square speaker and source markers
- depth-aware labels
- layout outline geometry
- source colors based on AED position

The display does not own the layout. It receives `config`, `layout`, `method`,
`params`, `speaker`, and `source` dumps from `s3g.layoutpan~`, so it only shows
layouts that the external itself supports.

## DSP Model

The current `s3g::LayoutPanner` engine supports:

- up to 64 sources
- up to 64 speakers
- fixed and preset speaker layouts
- editable/custom speaker positions
- distance and cosine panning methods
- per-source AED and XYZ control
- selected-source attributes for Max `attrui`

The native Max external focuses on clear Max messages, attributes, help patches,
and MC compatibility rather than reproducing an older patcher one-for-one.

## Future Method Ideas

Earlier panner designs included LBAP, DBAP, cosine, and VBAP-style behavior.
Those remain useful references for future panning methods, especially for
dome-oriented workflows, but they should be added only when they can be exposed
cleanly across the supported layout set.
