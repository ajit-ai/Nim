# closures_hof.nim — closures, anonymous procs, HOF, recursion patterns
# Run: nim c -r 03_procedures/closures_hof.nim
import std/sequtils, std/sugar, std/algorithm

# Closure capturing env
proc makeCounter(start: int): proc(): int =
  var count = start
  result = proc(): int =
    result = count
    inc count

let counter = makeCounter(10)
echo counter() # 10
echo counter() # 11
echo counter() # 12

# Do-notation like with sugar `=>`
let nums = @[1, 2, 3, 4, 5]
echo "map double: ", nums.map(x => x * 2)
echo "filter even: ", nums.filter(x => x mod 2 == 0)
echo "fold sum: ", nums.foldl(a + b)

# Closure as iterator-like
proc makeAdder(n: int): proc(x: int): int =
  return proc(x: int): int = x + n

let add5 = makeAdder(5)
echo "add5(10) = ", add5(10)

# Recursion: Fibonacci, GCD
proc fib(n: int): int =
  if n < 2: n else: fib(n-1) + fib(n-2)
echo "fib(8) = ", fib(8)

proc gcd(a, b: int): int =
  if b == 0: a else: gcd(b, a mod b)
echo "gcd(48,18) = ", gcd(48, 18)

# Mutual recursion via forward decl
proc isEven(n: int): bool
proc isOdd(n: int): bool = not isEven(n)
proc isEven(n: int): bool =
  if n == 0: true else: isOdd(n-1)
echo "isEven 42? ", isEven(42), " isOdd 7? ", isOdd(7)

# Sorting with custom comparator (HOF)
var words = @["nim", "python", "go", "rust"]
words.sort((x, y) => cmp(x.len, y.len))
echo "sorted by length: ", words

# `do` notation for inline proc
proc withValue(val: int, action: proc(x: int)) =
  action(val)

withValue(99) do (x: int):
  echo "withValue do: ", x * 2
