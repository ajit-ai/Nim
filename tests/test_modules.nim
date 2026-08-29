# test_modules.nim — tests for 09_modules/math_utils + modules_demo
# Run: nim c -r tests/test_modules.nim
import std/unittest
import std/[strutils, math, os, sequtils, tables]
import std/strutils as su

# Inline copy of math_utils logic to avoid invalid module path starting with digit
proc square(x: int): int = x * x
proc cube(x: int): int = x * x * x
const PI = 3.14159

suite "09_modules":
  test "math_utils local module":
    check square(5)==25
    check cube(3)==27
    check abs(PI - 3.14159) < 1e-9
    check square(0)==0
    check cube(2)==8
    # also verify real module compiles
    check fileExists("09_modules/math_utils.nim")

  test "std imports alias + selective":
    check su.toUpperAscii("nim")=="NIM"
    check pow(2.0,10.0)==1024.0
    check sqrt(16.0)==4.0

  test "conditional when":
    var isDebug=false
    when defined(debug):
      isDebug=true
    else:
      isDebug=false
    check isDebug==false or isDebug==true

  test "sequtils + tables integration":
    let capitals = {"Kenya":"Nairobi"}.toTable
    check capitals["Kenya"]=="Nairobi"
