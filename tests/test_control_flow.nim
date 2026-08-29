# test_control_flow.nim — tests for 02_control_flow/if_when_case.nim + loops + iterators
# Run: nim c -r tests/test_control_flow.nim
import std/unittest
import std/sequtils, std/strutils

suite "if / when / case":
  test "if expression grading":
    proc grade(score: int): string =
      if score >= 90: "A"
      elif score >= 80: "B"
      elif score >= 70: "C"
      else: "F"
    check grade(95) == "A"
    check grade(85) == "B"
    check grade(75) == "C"
    check grade(60) == "F"

  test "when compile-time branch":
    when NimVersion >= "2.0.0":
      check true
    else:
      check false

  test "case with strings":
    proc describe(lang: string): string =
      case lang
      of "Nim": "fast + expressive"
      of "Python", "Ruby": "dynamic"
      of "C", "C++": "low-level"
      else: "unknown"
    check describe("Nim") == "fast + expressive"
    check describe("Python") == "dynamic"
    check describe("Java") == "unknown"

  test "case with ranges":
    proc size(n: int): string =
      case n
      of 1..3: "small"
      of 4..6: "medium"
      of 7..9: "large"
      else: "out of range"
    check size(2) == "small"
    check size(5) == "medium"
    check size(7) == "large"
    check size(99) == "out of range"

  test "if as even/odd":
    let n = 7
    check (if n mod 2 == 0: "even" else: "odd") == "odd"
    check (if 4 mod 2 == 0: "even" else: "odd") == "even"

suite "loops: for, while, break, continue":
  test "for range collects":
    var res: seq[int]
    for i in 1..5: res.add(i)
    check res == @[1,2,3,4,5]

  test "countup / countdown":
    var up: seq[int]
    for i in countup(0, 10, 2): up.add(i)
    check up == @[0,2,4,6,8,10]
    var down: seq[int]
    for i in countdown(5, 1): down.add(i)
    check down == @[5,4,3,2,1]

  test "while loop decrement":
    var w = 3
    var seen: seq[int]
    while w > 0:
      seen.add(w)
      dec w
    check seen == @[3,2,1]
    check w == 0

  test "break / continue filtering":
    var res: seq[int]
    for i in 0..10:
      if i == 3: continue
      if i == 8: break
      res.add(i)
    check res == @[0,1,2,4,5,6,7]

  test "nested loops with pairs":
    let langs = @["Nim","Rust","Go"]
    var collected: seq[string]
    for idx, lang in langs.pairs:
      collected.add($idx & ":" & lang)
    check collected == @["0:Nim","1:Rust","2:Go"]

  test "labeled block break (outer)":
    var broke = false
    var product = 0
    block outer:
      for i in 1..5:
        for j in 1..5:
          if i * j > 12:
            broke = true
            product = i * j
            break outer
    check broke == true
    check product > 12

suite "iterators: custom yield, closure, sequtils":
  test "countTo iterator":
    iterator countTo(n: int): int =
      var i = 0
      while i < n:
        yield i
        inc i
    var s: seq[int]
    for v in countTo(5): s.add(v)
    check s == @[0,1,2,3,4]
    check countTo(3).toSeq == @[0,1,2]

  test "pairsWithIndex iterator":
    iterator pairsWithIndex(s: string): tuple[idx:int, ch:char] =
      for i, c in s: yield (i,c)
    var idxs: seq[int]
    var chars: seq[char]
    for idx, ch in pairsWithIndex("Nim"):
      idxs.add(idx); chars.add(ch)
    check idxs == @[0,1,2]
    check chars == @['N','i','m']

  test "countdown iterator":
    iterator countdownFrom(n: int): int =
      var i = n
      while i >= 0:
        yield i
        dec i
    check countdownFrom(3).toSeq == @[3,2,1,0]

  test "closure fibonacci first 10":
    iterator fibonacci(): int {.closure.} =
      var a=0; var b=1
      while true:
        yield a
        let nxt = a+b; a=b; b=nxt
    var fib = fibonacci
    var vals: seq[int]
    for _ in 0..<10: vals.add(fib())
    check vals == @[0,1,1,2,3,5,8,13,21,34]

  test "sequtils map/filter":
    let nums = @[1,2,3,4,5]
    check nums.mapIt(it*2) == @[2,4,6,8,10]
    check nums.filterIt(it mod 2 == 0) == @[2,4]
