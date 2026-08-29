# iterators.nim — custom iterators, closure iterators, yield
# Run: nim c -r 02_control_flow/iterators.nim

# Simple inline iterator (must be inline)
iterator countTo(n: int): int =
  var i = 0
  while i < n:
    yield i
    inc i

echo "countTo(5):"
for v in countTo(5):
  stdout.write $v & " "
echo ""

# Iterator with two yields (pairs)
iterator pairsWithIndex(s: string): tuple[idx: int, ch: char] =
  for i, c in s:
    yield (i, c)

echo "pairsWithIndex 'Nim':"
for idx, ch in pairsWithIndex("Nim"):
  echo idx, " -> ", ch

# Countdown iterator
iterator countdownFrom(n: int): int =
  var i = n
  while i >= 0:
    yield i
    dec i

echo "countdownFrom(3): ", countdownFrom(3).toSeq
import std/sequtils

# Closure iterator — can keep state across calls (requires closure)
iterator fibonacci(): int {.closure.} =
  var a = 0
  var b = 1
  while true:
    yield a
    let nxt = a + b
    a = b
    b = nxt

echo "first 10 fibonacci:"
var fib = fibonacci
for _ in 0..<10:
  stdout.write $fib() & " "
echo ""

# Using standard sequtils iterators
let nums = @[1,2,3,4,5]
echo "map double: ", nums.mapIt(it * 2)
echo "filter even: ", nums.filterIt(it mod 2 == 0)
