# operators.nim — arithmetic, comparison, logical, bitwise, string ops
# Run: nim c -r 01_basics/operators.nim

echo "== Arithmetic =="
echo "15 + 6 = ", 15 + 6
echo "15 - 6 = ", 15 - 6
echo "15 * 6 = ", 15 * 6
echo "33.5 / 2 = ", 33.5 / 2
echo "15 div 6 = ", 15 div 6   # integer division
echo "15 mod 6 = ", 15 mod 6
echo "2 ^ 8 (pow) = ", 2 ^ 8   # actually xor! use pow for exponent
import std/math
echo "pow(2,8) = ", pow(2.0, 8.0)

echo "\n== Comparison =="
echo "5 == 5: ", 5 == 5
echo "5 != 6: ", 5 != 6
echo "5 < 6: ", 5 < 6
echo "10 >= 10: ", 10 >= 10

echo "\n== Logical =="
echo "true and false = ", true and false
echo "true or false = ", true or false
echo "not true = ", not true
echo "true xor false = ", true xor false

echo "\n== Bitwise =="
echo "5 and 3 (binary 101 & 011) = ", 5 and 3
echo "5 or 3 = ", 5 or 3
echo "5 xor 3 = ", 5 xor 3
echo "not 5 = ", not 5
echo "5 shl 1 = ", 5 shl 1
echo "5 shr 1 = ", 5 shr 1

echo "\n== String =="
echo "\"nim\" & \"ble\" = ", "nim" & "ble"
echo "\"ha\" * 3 = ", "ha" * 3
import std/strutils
echo "\"nim\" in \"nimble\" = ", "nim" in "nimble"
echo "join: ", ["a","b","c"].join(", ")

echo "\n== Ternary-like (if expression) =="
let age = 20
let status = if age >= 18: "adult" else: "minor"
echo "age ", age, " is ", status

echo "\n== In-place ops =="
var n = 10
n += 5; echo "n +=5 -> ", n
n *= 2; echo "n *=2 -> ", n
n -= 3; echo "n -=3 -> ", n
