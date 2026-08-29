# Package
version       = "0.2.0"
author        = "Ajit Kumar"
description   = "Nim by Example — complete feature & algorithm demos"
license       = "MIT"
srcDir        = "."

# Dependencies
requires "nim >= 2.0.0"

task test, "Run all unittest suites":
  # Run each suite individually — fails fast on error
  exec "nim c -r tests/test_variables.nim"
  exec "nim c -r tests/test_datatypes.nim"
  exec "nim c -r tests/test_operators.nim"
  exec "nim c -r tests/test_input_output.nim"
  exec "nim c -r tests/test_control_flow.nim"
  exec "nim c -r tests/test_hello_values.nim"
  echo "All tests passed!"

task testAll, "Run aggregator":
  exec "nim c -r tests/all_tests.nim"
