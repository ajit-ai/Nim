# loops.nim — for, while, break, continue, nested
# Run: nim c -r 02_control_flow/loops.nim
import std/strutils

echo "== for with range =="
for i in 1..5:
  stdout.write $i & " "
echo ""

echo "== for with countup/countdown =="
for i in countup(0, 10, 2):
  stdout.write $i & " "
echo ""
for i in countdown(5, 1):
  stdout.write $i & " "
echo ""

echo "== while =="
var w = 3
while w > 0:
  echo "w=", w
  dec w

echo "== break / continue =="
for i in 0..10:
  if i == 3: continue  # skip 3
  if i == 8: break     # stop at 8
  stdout.write $i & " "
echo ""

echo "== nested loops =="
for x in 1..3:
  for y in 1..3:
    if x == y: continue
    echo &"({x},{y})"

echo "== block + break (labeled break) =="
block outer:
  for i in 1..5:
    for j in 1..5:
      if i * j > 12:
        echo "breaking outer at i=", i, " j=", j
        break outer
      stdout.write &"{i*j} "
  echo ""

echo "== for with enumerate (pairs) =="
let langs = @["Nim","Rust","Go"]
for idx, lang in langs.pairs:
  echo idx, ": ", lang

echo "== while true with break =="
var c = 0
while true:
  inc c
  if c >= 3: break
  echo "c=", c
