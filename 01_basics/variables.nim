# variables.nim — var / let / const, type inference, scopes
# Run: nim c -r 01_basics/variables.nim
# Concepts: var (mutable), let (immutable), const (compile-time), block scope, shadowing

var mutableInt = 10           # mutable, inferred int
let immutableStr = "Nim"      # immutable binding
const compileTimePi = 3.14159 # compile-time constant

echo "mutableInt = ", mutableInt
mutableInt = 20
echo "mutableInt after = ", mutableInt

# immutableStr = "changed"  # compile error! let cannot be reassigned

echo "immutableStr = ", immutableStr
echo "const Pi = ", compileTimePi

# Explicit types
var x: int = 42
var y: float = 3.14
var flag: bool = true
var ch: char = 'A'
echo "x=", x, " y=", y, " flag=", flag, " ch=", ch

# Multiple declarations
var a, b, c = 10      # all 10 (a,b get int, c=10)
var p, q: int         # default 0
echo "a=", a, " b=", b, " c=", c, " p=", p

# Block scope
block scopeDemo:
  var inner = 99
  echo "inner = ", inner
# echo inner  # error: undeclared

# Shadowing
var v = 1
block:
  var v = 2  # shadows outer v
  echo "inner v=", v
echo "outer v=", v

# Type inference with auto
let inferred = 100 + 200
echo "inferred type is int, value=", inferred, " sizeof=", sizeof(inferred)
