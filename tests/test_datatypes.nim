# test_datatypes.nim — tests for 01_basics/datatypes.nim
# Run: nim c -r tests/test_datatypes.nim
import std/unittest
import std/strutils

suite "datatypes: ints, floats, bool, char, string, conversions":
  test "integer types ranges":
    var i8: int8 = 127
    var i16: int16 = 32000
    var i32: int32 = 2_000_000_000
    var i64: int64 = 9_000_000_000'i64
    var u: uint = 42'u
    check i8 == 127
    check i16 == 32000
    check i32 == 2_000_000_000
    check i64 == 9_000_000_000
    check u == 42
    check sizeof(int) in {4, 8}  # platform dependent

  test "float types":
    var f32: float32 = 3.14'f32
    var f64: float = 2.71828
    check abs(f32 - 3.14) < 0.001
    check abs(f64 - 2.71828) < 1e-6

  test "bool and char":
    var t = true
    var f = false
    check (not t) == false
    check (t and f) == false
    check (t or f) == true
    var ch: char = 'Z'
    check ord(ch) == 90
    check chr(65) == 'A'
    check chr(ord(ch)) == ch

  test "string ops":
    var s = "nimble"
    check len(s) == 6
    check s[0] == 'n'
    check s[^1] == 'e'
    check s & "!" == "nimble!"
    check repeat("ha", 3) == "hahaha"
    let raw = r"C:\path\to\file.nim"
    check raw == "C:\\path\\to\\file.nim"
    let multi = """line1
line2"""
    check multi.contains("line1")

  test "conversions":
    let intVal = 42
    let floatVal = float(intVal)
    check floatVal == 42.0
    let strVal = $intVal
    check strVal == "42"
    check parseInt("123") == 123
    check parseFloat("3.14") == 3.14
    check intVal is int
    check strVal is string

  test "distinct type":
    type Meters = distinct float
    let m: Meters = 5.0.Meters
    check m.float == 5.0
    check Meters(3.0).float * 2 == 6.0
