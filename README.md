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
- Preset speaker layouts including quad, quad+OH, domes, rings, surround
  formats, dodeca12, and icosahedron20.
- V8UI field display that follows the object state.
- Max MC wrapper support through `@mc 1`.

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
- `dome24`
- `dome25`
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
package/docs/          Additional package docs
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

See [`package/docs/testing.md`](package/docs/testing.md).

## License

`s3g-max` uses the BSD 3-Clause license. The Max SDK remains owned and licensed
by Cycling '74; build support is fetched from the official `max-sdk-base`
repository.
