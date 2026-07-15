# Testing s3g Max Externals

The practical Max-side regression harness for this package is
Cycling '74's `max-test` package:

https://github.com/Cycling74/max-test

For Max 9, install and build it in the Max 9 Packages folder:

```sh
git clone --recursive https://github.com/Cycling74/max-test.git "$HOME/Documents/Max 9/Packages/max-test"
cmake -S "$HOME/Documents/Max 9/Packages/max-test" -B "$HOME/Documents/Max 9/Packages/max-test/build" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build "$HOME/Documents/Max 9/Packages/max-test/build" --config Release
```

The built bundle is `max-test/extensions/oscar.mxo`; it registers the `test.*`
objects such as `test.sample~`, `test.assert`, and `test.terminate`.
Restart Max or refresh the file browser after building so Max rescans the new
package.

Use it for host-level behavior that the C++ smoke tests cannot see:

- whether an external loads in Max
- whether signal outlets produce non-silent output
- whether messages and attributes update the object state
- whether layout changes dump the expected state for V8UI display objects
- whether console errors appear while opening help/test patchers

## Test Patcher Rules

`max-test` patchers should:

- end in `.maxtest.maxpat`
- start themselves, usually from `loadbang`
- contain one or more `test.assert` / `test.equals` / `test.sample~` checks
- terminate themselves by banging `test.terminate`

For audio-rate externals, prefer `test.sample~` over `snapshot~` so results are
sample-accurate enough to catch silent-output regressions.

## First Useful Coverage

Start with small deterministic patchers instead of testing the full help patch:

- `package/patchers/s3g.layoutpan-smoke.maxtest.maxpat`
  - instantiate `s3g.layoutpan~ 2 6 quad+oh`
  - set DSP on
  - feed deterministic nonzero signals
  - send `layout quad+oh`
  - sample one or more outputs and assert nonzero output
  - assert the info outlet reports `layout quad+oh`, `params`, `speaker`, and
    `source` messages without Max console errors
- `s3g.subxover~ 6 @layout quad @subcount 2`
  - feed deterministic nonzero signal
  - assert high outputs and sub outputs respond
  - change layout and assert `highchannels` and `suboffset` update together

This keeps help patch CPU and V8UI drawing cost out of the first regression
tests. Help patch tests can be added later as load/open smoke tests.

## Optimization Regression Tests

For DSP optimization work, keep at least two Max-facing tests:

- a normal generic object path test, such as `s3g.layoutpan~ 2 6 quad+oh`
- an experimental fast-kernel path test, if a fixed-width optimized object or
  `@kernel` mode is added

The C++ smoke tests can prove the shared DSP methods work in isolation, but Max
tests are the guard for MSP pointer/outlet ordering, signal-vector behavior, and
host-specific silence regressions.
