# procs.nim — procedures, func, overloads, defaults, var params, discard
# Run: nim c -r 03_procedures/procs.nim
import std/strformat, std/math

# Basic proc (mutates via var, returns value)
proc greet(name: string): string =
  result = &"Hello, {name}!"

echo greet("Ada")

# Default arguments & named params
proc power(base: float, exp: float = 2.0): float =
  pow(base, exp)

echo "power(3) = ", power(3)
echo "power(2, 8) = ", power(2, 8)
echo "power(exp=3, base=2) = ", power(exp=3, base=2)

# Overloading
proc add(a, b: int): int = a + b
proc add(a, b: float): float = a + b
proc add(a, b, c: int): int = a + b + c

echo "add int: ", add(2, 3)
echo "add float: ", add(2.5, 3.1)
echo "add 3 ints: ", add(1, 2, 3)

# var params (pass by reference)
proc incVar(x: var int) = inc x
var n = 10
incVar(n)
echo "incVar 10 -> ", n

# func = no side effects (compiler enforced)
func pureAdd(a, b: int): int = a + b
echo "pureAdd: ", pureAdd(5, 7)

# discard explicit (for procs returning value you want to ignore)
proc log(msg: string): bool = echo "[log] ", msg; true
discard log("side effect via discard not needed")
# void proc called normally
proc logVoid(msg: string) = echo "[logVoid] ", msg
logVoid("direct call, no discard needed")

# recursion
proc factorial(n: int): int =
  if n <= 1: 1 else: n * factorial(n-1)
echo "factorial(5) = ", factorial(5)

# Multiple return via tuple
proc divmod(a, b: int): (int, int) =
  (a div b, a mod b)
let (q, r) = divmod(17, 5)
echo &"divmod(17,5) = q={q} r={r}"

# Higher-order: proc as param
proc applyTwice(f: proc(x: int): int, x: int): int = f(f(x))
proc double(x: int): int = x * 2
echo "applyTwice double 3 = ", applyTwice(double, 3)

# Anonymous proc (lambda)
let square = proc(x: int): int = x * x
echo "square(6) = ", square(6)
