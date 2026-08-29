# all_tests.nim — aggregator runner for `nim c -r tests/all_tests.nim` or testament
# Run: nim c -r tests/all_tests.nim
import std/unittest

# Importing each suite registers it — simply include them
include test_variables
include test_datatypes
include test_operators
include test_input_output
include test_control_flow
include test_hello_values
include test_procs
include test_collections
include test_types
include test_oop
include test_metaprogramming
include test_exceptions
include test_modules
include test_file_io
include test_concurrency
include test_sorting
include test_searching
include test_graph
include test_dp
include test_math
include test_strings
include test_examples
