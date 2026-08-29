# exceptions.nim — try/except/finally, defer, Option/Result patterns
# Run: nim c -r 08_error_handling/exceptions.nim
import std/[options, strformat, strutils]

# ---- Custom exception ----
type AppError* = object of CatchableError
  code*: int

proc risky(val: int): int =
  if val < 0:
    raise newException(AppError, "negative not allowed")
  if val == 0:
    raise newException(ValueError, "zero not allowed")
  return 100 div val

# ---- try / except / finally ----
for v in [-5, 0, 5]:
  try:
    echo &"risky({v}) = {risky(v)}"
  except AppError as e:
    echo &"  AppError code={e.code} msg={e.msg}"
  except ValueError as e:
    echo &"  ValueError: {e.msg}"
  except CatchableError as e:
    echo &"  Catchable: {e.msg}"
  finally:
    echo "  finally block always runs"

# ---- defer (Go-like cleanup) ----
proc withDefer() =
  echo "enter withDefer"
  defer: echo "defer: cleanup 1"
  defer: echo "defer: cleanup 2 (runs first, LIFO)"
  echo "  doing work..."
  # defer blocks run on scope exit, even on return/exception

withDefer()

# ---- Option pattern (prefer over nil) ----
proc findEven(nums: seq[int]): Option[int] =
  for n in nums:
    if n mod 2 == 0: return some(n)
  return none(int)

let r1 = findEven(@[1,3,5])
echo "findEven [1,3,5]: isSome=", r1.isSome, " get=", r1.get(999)
let r2 = findEven(@[1,2,3])
echo "findEven [1,2,3]: ", r2.get()

# ---- Result pattern (manual) ----
type Result[T, E] = object
  case ok: bool
  of true: value: T
  of false: error: E

proc ok[T, E](v: T): Result[T, E] = Result[T, E](ok: true, value: v)
proc err[T, E](e: E): Result[T, E] = Result[T, E](ok: false, error: e)

proc safeDiv(a, b: int): Result[int, string] =
  if b == 0: err[int, string]("division by zero")
  else: ok[int, string](a div b)

let res1 = safeDiv(10, 2)
if res1.ok: echo "10/2=", res1.value else: echo "err=", res1.error
let res2 = safeDiv(10, 0)
echo "10/0 ok? ", res2.ok, " err=", res2.error

# ---- assert + doAssert ----
let name = "Nim"
doAssert name.len == 3, "name should be Nim"
# doAssert false  # would raise AssertionDefect

# ---- try with return ----
proc parseOrDefault(s: string, def: int): int =
  try: parseInt(s)
  except ValueError: def

echo "parse 'abc' -> ", parseOrDefault("abc", -1)
echo "parse '123' -> ", parseOrDefault("123", -1)
