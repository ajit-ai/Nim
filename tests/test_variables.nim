# test_variables.nim — tests for 01_basics/variables.nim
# Run: nim c -r tests/test_variables.nim
import std/unittest

suite "variables: var / let / const / scope / shadowing":
  test "var mutable reassignment":
    var mutableInt = 10
    check mutableInt == 10
    mutableInt = 20
    check mutableInt == 20
    mutableInt += 5
    check mutableInt == 25

  test "let immutable binding":
    let immutableStr = "Nim"
    check immutableStr == "Nim"
    check len(immutableStr) == 3

  test "const compile-time":
    const compileTimePi = 3.14159
    check compileTimePi > 3.14
    check compileTimePi < 3.15
    const doubled = compileTimePi * 2
    check doubled > 6.28

  test "explicit typed vars":
    var x: int = 42
    var y: float = 3.14
    var flag: bool = true
    var ch: char = 'A'
    check x == 42
    check y == 3.14
    check flag == true
    check ch == 'A'
    check ord(ch) == 65

  test "multiple declarations defaults":
    var a, b, c = 10
    check a == 10 and b == 10 and c == 10
    var p, q: int
    check p == 0 and q == 0  # default init

  test "block scope isolation":
    var outer = 1
    block scopeDemo:
      var inner = 99
      check inner == 99
      outer = inner
    check outer == 99

  test "shadowing inner vs outer":
    var v = 1
    block:
      var v = 2
      check v == 2
    check v == 1

  test "type inference sizeof":
    let inferred = 100 + 200
    check inferred == 300
    check inferred is int
    check sizeof(inferred) == sizeof(int)
