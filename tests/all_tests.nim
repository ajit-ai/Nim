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
