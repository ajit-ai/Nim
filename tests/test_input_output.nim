# test_input_output.nim — tests for 01_basics/input_output.nim
# Run: nim c -r tests/test_input_output.nim
import std/unittest
import std/strformat, std/strutils, std/os

suite "input_output: formatting, conversions, os params":
  test "fmt interpolation":
    let name = "Ada"
    let lang = "Nim"
    let ver = 2.2
    check fmt"{name} loves {lang} v{ver:.1f}" == "Ada loves Nim v2.2"
    check &"2 + 2 = {2+2}" == "2 + 2 = 4"

  test "format helpers":
    check formatFloat(3.14159, precision=2) == "3.1" or formatFloat(3.14159, precision=2) == "3.14"
    # toHex length check (255 = FF)
    check toHex(255).toLower.contains("ff")
    check toHex(16) != ""

  test "string parsing simulated input":
    let simulated = "42"
    let num = parseInt(simulated)
    check num == 42
    check num * 2 == 84
    let f = parseFloat("3.14")
    check abs(f - 3.14) < 1e-9

  test "strip and parse":
    check "  hello  ".strip() == "hello"
    check parseInt("  100  ".strip()) == 100

  test "os param helpers (non-crash)":
    # paramStr(0) is program name, never empty
    check paramStr(0).len > 0
    # paramCount returns >=0 and doesn't throw
    check paramCount() >= 0

  test "echo / $ conversions":
    check $42 == "42"
    check $true == "true"
    check $(3.14) == "3.14"
    check $'A' == "A"
