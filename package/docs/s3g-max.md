# s3g Max Externals

`s3g-max` contains native Max/MSP wrappers around the shared C++ DSP engines in
the sibling `s3g-dsp` repository.

Current objects focus on spatial layout, ambisonic decoding, subwoofer support,
and main-array filtering:

- `s3g.layoutpan~`
- `s3g.subxover~`
- `s3g.ambidecoder~`
- `s3g.ambisubdecoder~`
- `s3g.arrayhpf~`
- `s3g.ambigrain~`

`s3g.ambigrain~` uses Max `buffer~` objects as the file-loading surface. The
external snapshots the named buffer on `refresh`, then the audio thread renders
the shared `s3g::AmbiGrainProcessor` engine from that immutable sample.
