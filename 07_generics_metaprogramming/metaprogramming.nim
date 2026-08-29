# metaprogramming.nim — generics, templates, macros, concepts, static
# Run: nim c -r 07_generics_metaprogramming/metaprogramming.nim
import std/[macros, strformat, sequtils]

# ---- Generics ----
proc identity[T](x: T): T = x
echo "identity int: ", identity(42)
echo "identity string: ", identity("nim")

proc first[T](s: seq[T]): T = s[0]
echo "first: ", first(@[10,20,30])

# Generic object
type Stack[T] = object
  items: seq[T]

proc push[T](s: var Stack[T], v: T) = s.items.add(v)
proc pop[T](s: var Stack[T]): T = s.items.pop()
proc isEmpty[T](s: Stack[T]): bool = s.items.len == 0

var st = Stack[int](items: @[])
st.push(1); st.push(2); st.push(3)
echo "stack pop: ", st.pop()
echo "empty? ", st.isEmpty()

# ---- Concepts (generic constraints) ----
type Addable = concept x, y
  x + y is typeof(x)

proc sumPair[T: Addable](a, b: T): T = a + b
echo "sumPair: ", sumPair(10, 20)
echo "sumPair float: ", sumPair(1.5, 2.5)

# ---- Static params (compile-time values) ----
proc repeatStatic[N: static int](c: char): string =
  result = ""
  for _ in 0..<N: result.add(c)
echo "repeatStatic[5]('a'): ", repeatStatic[5]('a')

# ---- Templates (hygienic code substitution, lazy eval) ----
template withLog(msg: string, body: untyped) =
  echo "enter: " & msg
  body
  echo "exit: " & msg

withLog("block"):
  echo "  inside block"

# Template with gensym: `inject`
template `:=`(name, val: untyped) =
  var name = val

`:=`(myVar, 123)
echo "injected myVar: ", myVar

# ---- Macros (AST manipulation) ----
macro debug(e: untyped): untyped =
  # prints expr and its value at runtime
  let s = e.toStrLit
  result = quote do:
    echo `s` & " = " & $`e`

let x = 10
let y = 20
debug(x + y)
debug(x * y + 5)

# Macro to generate enum utils
macro genStrEnum(name: untyped, fields: varargs[untyped]): untyped =
  result = newStmtList()
  var enumDef = nnkEnumTy.newTree(newEmptyNode())
  for f in fields:
    enumDef.add(f)
  result.add(nnkTypeSection.newTree(
    nnkTypeDef.newTree(name, newEmptyNode(), enumDef)
  ))

# Simple stringify macro
macro strify(args: varargs[untyped]): untyped =
  var s = ""
  for i, a in args: s.add(a.toStrLit.strVal & (if i < args.len-1: ", " else: ""))
  newLit(s)

echo "strify: ", strify(foo, bar, baz)

# ---- Static assert & when ----
static:
  assert 2 + 2 == 4

when NimVersion >= "2.0.0":
  echo "Nim version: ", NimVersion

# Computed at compile time
const ctVal = block:
  var s = 0
  for i in 1..5: s += i
  s
echo "compile-time sum 1..5: ", ctVal
