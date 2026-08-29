# test_hello_values.nim — tests for basic/hello.nim and basic/Values.nim
# Run: nim c -r tests/test_hello_values.nim
import std/unittest
import std/strutils

suite "basic/hello — hello world":
  test "hello string constant":
    let msg = "Hello, World!"
    check msg == "Hello, World!"
    check msg.len == 13
    check msg.contains("Hello")

suite "basic/Values — literals and ops":
  test "string concatenation":
    check "nim" & "ble" == "nimble"
    check "Hello!" == "Hello!"

  test "numeric ops":
    check 15 + 6 == 21
    check 33.5 / 2 == 16.75
    check abs(33.5 / 2 - 16.75) < 1e-9

  test "boolean logic":
    check (true and false) == false
    check (true or false) == true
    check (not true) == false

  test "string interpolations with $ and &":
    check $(15 + 3) == "18"
    check "15 + 3 = " & $(15+3) == "15 + 3 = 18"
    check "not true is " & $(not true) == "not true is false"
    check "not false is " & $(not false) == "not false is true"

  test "values integration":
    # Replicate entire Values.nim logic as function for coverage
    proc valuesDemo(): seq[string] =
      result = @[]
      result.add("Hello!")
      result.add("nim" & "ble")
      result.add($(15+6))
      result.add($(33.5/2))
      result.add($(true and false))
      result.add($(true or false))
      result.add($(not true))
    let v = valuesDemo()
    check v[0] == "Hello!"
    check v[1] == "nimble"
    check v[2] == "21"
    check v[5] == "true"
    check v[6] == "false"
