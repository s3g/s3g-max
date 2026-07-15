# s3g-max

Max/MSP externals for spatial audio, ambisonic decoding, subwoofer
routing, and multichannel utility work.

`s3g-max` is a Max package that builds `.mxo` externals from the shared C++
DSP engines in the sibling [`s3g-dsp`](../s3g-dsp) repository. The package is
designed for Max 9 on macOS first, with help patches, V8UI displays, and a
symlink-based local install workflow.

## Objects

### `s3g.layoutpan~`

Direct layout panner for up to 64 sources and 64 outputs.

```max
s3g.layoutpan~ <inputs> <outputs> <layout>
s3g.layoutpan~ <inputs> <outputs> <layout> @mc 1
```

Highlights:

- Distance and cosine panning methods.
- AED and XYZ source control.
- Inside-source modes for distance behavior inside the unit speaker perimeter.
- Smooth negative-elevation rolloff when the layout has no real lower speakers.
- Preset speaker layouts including quad, quad+OH, domes, rings, surround
  formats, dodeca12, and icosahedron20.
- V8UI field display that follows the object state.
- Max MC wrapper support through `@mc 1`.

### `s3g.dbappan~`, `s3g.lbappan~`, `s3g.vbappan~`

Alternative direct panners using the same curated layout set and source-control
messages as `s3g.layoutpan~`.

```max
s3g.dbappan~ <inputs> <outputs> <layout>
s3g.lbappan~ <inputs> <outputs> <layout>
s3g.vbappan~ <inputs> <outputs> <layout>
```

Highlights:

- `s3g.dbappan~` uses distance-based amplitude panning.
- `s3g.lbappan~` uses layer/local-lobe amplitude panning.
- `s3g.vbappan~` uses vector-base amplitude panning.
- DBAP shares the same lower-hemisphere rolloff behavior as `s3g.layoutpan~`
  when a layout has no real lower speakers.
- LBAP and VBAP use the shared topology-aware solver from `s3g-dsp`.
- For 2D layouts, elevation becomes a smooth level change into silent
  imaginary top/bottom speakers instead of a no-op.
- For partial 3D layouts, imaginary solver points improve weak topology while
  real output channel counts remain unchanged.
- Max MC wrapper support is available through `@mc 1`.

### `s3g.subxover~`

Subwoofer crossover and low-frequency send utility for speaker arrays.

```max
s3g.subxover~ <channels>
```

Use it after a panner or other speaker-layout signal stream. It supports
1-8 sub channels, contiguous sub-channel offsets, split crossover mode, and
low-frequency send mode.

### `s3g.ambidecoder~`

Ambisonic speaker decoder for ACN/SN3D input. The supported speaker layout set
matches the current Max object and CLAP Ambi Speaker Decoder layout set:

- `quad`
- `cube8`
- `cube17`
- `cube41`
- `lpac41`
- `dome24`
- `dome25`
- `srst25`
- `quad+oh`
- `sphere24`
- `dodeca12`
- `icosahedron20`
- `octo`

### `s3g.ambisubdecoder~`

Ambisonic subwoofer decoder for 1-8 sub outputs. A single sub uses the
omnidirectional component; multi-sub layouts decode a lower-order horizontal
field and place sub channel 1 at -45 degrees, then proceed clockwise.

### `s3g.arrayhpf~`

Post-decoder high-pass filter for main speaker arrays. Intended to pair with
`s3g.ambisubdecoder~` when low-frequency content is decoded separately.

### `s3g.arraydelay~`

Per-channel speaker calibration delay for physical array alignment.

```max
s3g.arraydelay~ <channels>
s3g.arraydelay~ <channels> @mc 1
```

Use `delay <channel> <ms>` for a single speaker or `delays <list>` to paste a
calibration table in channel order.

### `s3g.arraytrim~`

Per-channel speaker calibration trim for physical array balancing.

```max
s3g.arraytrim~ <channels>
s3g.arraytrim~ <channels> @mc 1
```

Use `gain <channel> <dB>` / `trim <channel> <dB>` for one speaker, or
`gains <list>` to paste a gain table in channel order. `mute`, `mutes`,
`invert`, and `inverts` support channel mute and polarity checks.

### `s3g.ambigrain~`

Ambisonic grain processor using a named Max `buffer~` as the file-loading
surface. Send `refresh` after replacing or editing the buffer so the external
can snapshot the sample data for realtime playback.

## Install From Source

Requirements:

- macOS
- Max 9
- Xcode command line tools or Xcode
- CMake 3.25 or newer
- A sibling checkout of [`s3g-dsp`](../s3g-dsp)
- Network access on first configure so CMake can fetch Cycling '74
  `max-sdk-base`

From the repository root:

```sh
./scripts/build-release.sh
./scripts/install-local-package.sh
```

The install script links this checkout's `package/` directory into:

```text
~/Documents/Max 9/Packages/s3g-max
```

That keeps the GitHub checkout as the source of truth while Max sees a normal
package. To target another package folder:

```sh
S3G_MAX_PACKAGE_ROOT="/path/to/Packages/s3g-max" ./scripts/install-local-package.sh
```

If the DSP repo is not a sibling directory, configure manually:

```sh
cmake -S . -B build-make -G "Unix Makefiles" -DS3G_DSP_DIR=/path/to/s3g-dsp
cmake --build build-make --config Release
```

## Package Layout

```text
source/externals/      C++ Max external targets
package/externals/     Built .mxo bundles
package/help/          Max help patchers
package/javascript/    V8UI display scripts
package/patchers/      Max-test patchers
scripts/               Build and install helpers
```

## Architecture

The DSP source of truth lives in `s3g-dsp`. This repository focuses on native
Max/MSP integration: object wrappers, Max attributes and messages, help
patches, package structure, V8UI displays, and local install scripts.

The Max externals do not host CLAP plugins inside Max and are not generated
from RNBO exports.

## Testing

Shared C++ DSP behavior is covered by the smoke tests in `s3g-dsp`. Max-host
behavior can be checked with Cycling '74's `max-test` package using the patchers
in `package/patchers/`.

## License

`s3g-max` uses the BSD 3-Clause license. The Max SDK remains owned and licensed
by Cycling '74; build support is fetched from the official `max-sdk-base`
repository.
