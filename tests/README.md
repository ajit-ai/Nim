# Tests — one suite per demo

Each `test_*.nim` uses `std/unittest` (`suite`/`test`/`check`) and mirrors the logic of a demo file.

| Test file | Covers | Demo source |
|-----------|--------|-------------|
| `test_variables.nim` | var/let/const, scope, shadowing | `01_basics/variables.nim` |
| `test_datatypes.nim` | ints/floats/bool/char/string/distinct | `01_basics/datatypes.nim` |
| `test_operators.nim` | arithmetic/bitwise/string ops | `01_basics/operators.nim` |
| `test_input_output.nim` | fmt/strformat/os params | `01_basics/input_output.nim` |
| `test_control_flow.nim` | if/when/case + loops + iterators | `02_control_flow/*.nim` |
| `test_hello_values.nim` | hello/world + Values | `basic/*.nim` |
| `all_tests.nim` | aggregator (includes all) | — |

## Run

```bash
# Single suite
nim c -r tests/test_variables.nim

# All suites via nimble (recommended)
nimble test

# Aggregator
nim c -r tests/all_tests.nim

# Via testament (alternative)
testament --megatest cat tests
```

All tests are expected to show `[OK]` for each `test` block and exit 0.
