# Package
version       = "0.2.0"
author        = "Ajit Kumar"
description   = "Nim by Example — complete feature & algorithm demos"
license       = "MIT"
srcDir        = "."

# Dependencies
requires "nim >= 2.0.0"

task test, "Run all unittest suites":
  # 01-02 basics
  exec "nim c -r tests/test_variables.nim"
  exec "nim c -r tests/test_datatypes.nim"
  exec "nim c -r tests/test_operators.nim"
  exec "nim c -r tests/test_input_output.nim"
  exec "nim c -r tests/test_control_flow.nim"
  exec "nim c -r tests/test_hello_values.nim"
  # 03-05 procedures/collections/types
  exec "nim c -r tests/test_procs.nim"
  exec "nim c -r tests/test_collections.nim"
  exec "nim c -r tests/test_types.nim"
  # 06-08 oop/meta/exceptions
  exec "nim c -r tests/test_oop.nim"
  exec "nim c -r tests/test_metaprogramming.nim"
  exec "nim c -r tests/test_exceptions.nim"
  # 09-11 modules/io/concurrency
  exec "nim c -r tests/test_modules.nim"
  exec "nim c -r tests/test_file_io.nim"
  exec "nim c -r tests/test_concurrency.nim"
  # algorithms
  exec "nim c -r tests/test_sorting.nim"
  exec "nim c -r tests/test_searching.nim"
  exec "nim c -r tests/test_graph.nim"
  exec "nim c -r tests/test_dp.nim"
  exec "nim c -r tests/test_math.nim"
  exec "nim c -r tests/test_strings.nim"
  exec "nim c -r tests/test_examples.nim"
  echo "All tests passed! (22 suites)"

task testAll, "Run aggregator":
  exec "nim c -r tests/all_tests.nim"
