# test_operators.nim — tests for 01_basics/operators.nim
# Run: nim c -r tests/test_operators.nim
import std/unittest
import std/math
import std/strutils

suite "operators":
  test "arithmetic":
    check 15 + 6 == 21
    check 15 - 6 == 9
    check 15 * 6 == 90
    check 33.5 / 2 == 16.75
    check 15 div 6 == 2
    check 15 mod 6 == 3
    check pow(2.0, 8.0) == 256.0
    # ^ is xor, not power
    check (2 xor 8) == 10

  test "comparison":
    check (5 == 5) == true
    check (5 != 6) == true
    check (5 < 6) == true
    check (10 >= 10) == true
    check (3 > 5) == false

  test "logical":
    check (true and false) == false
    check (true or false) == true
    check (not true) == false
    check (true xor false) == true
    check (false xor false) == false

  test "bitwise":
    check (5 and 3) == 1   # 101 & 011 = 001
    check (5 or 3) == 7    # 101 | 011 = 111
    check (5 xor 3) == 6   # 101 ^ 011 = 110
    check (5 shl 1) == 10  # 0101 << 1 = 1010
    check (5 shr 1) == 2   # 0101 >> 1 = 0010
    # not performs bitwise complement
    check (not 0) == -1

  test "string operators":
    check "nim" & "ble" == "nimble"
    check repeat("ha", 3) == "hahaha"
    check ("nim" in "nimble") == true
    check ["a","b","c"].join(", ") == "a, b, c"

  test "ternary-like if expression":
    let age = 20
    let status = if age >= 18: "adult" else: "minor"
    check status == "adult"
    let age2 = 16
    check (if age2 >= 18: "adult" else: "minor") == "minor"

  test "in-place ops":
    var n = 10
    n += 5; check n == 15
    n *= 2; check n == 30
    n -= 3; check n == 27
    n = n div 3; check n == 9
