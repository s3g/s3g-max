# s3g.layoutpan~ With Max MC

Because the object name already uses the `s3g.` prefix, MC mode is exposed as a
construction-time attribute instead of a separate `mc.s3g.*` class:

```text
s3g.layoutpan~ <inputs> <outputs> <layout> @mc 1
```

Example:

```text
s3g.layoutpan~ 2 6 quad+oh @mc 1
```

Do not create or use an object named `s3g.mc.layoutpan~`. Also avoid
`mc.s3g.layoutpan~`; Max treats that as a literal class lookup for this dotted
third-party namespace.

The arguments still belong to `s3g.layoutpan~`:

- `<inputs>` is the source count the panner expects.
- `<outputs>` is the speaker/output count the panner produces.
- `<layout>` selects the supported speaker layout.

The underlying object keeps the same messages and attributes as
`s3g.layoutpan~`, including `layout`, `method`, `source`, `sourcexyz`, `select`,
`azimuth`, `elevation`, `distance`, `sourcegain`, and `dump`.

`@mc 1` changes the I/O shape at construction:

- one multichannel signal inlet
- one multichannel signal outlet
- one info outlet

`@mc` is not intended to be toggled live after object creation; recreate the
object to switch between fixed-width and MC mode.

Preset layout kernels are used when the object's requested channel counts match
the selected preset. Custom speaker editing remains available on the base
object, but custom layouts fall back to the generic DSP path.
