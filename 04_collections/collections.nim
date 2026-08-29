# collections.nim — array, seq, string, Table, sets, tuples, sequtils
# Run: nim c -r 04_collections/collections.nim
import std/[tables, sets, sequtils, strutils, algorithm, sugar, strformat]

# ---- Array (static) ----
var arr: array[3, int] = [1, 2, 3]
echo "array: ", arr, " len=", len(arr), " arr[1]=", arr[1]

# ---- Seq (dynamic) ----
var seq1 = @[10, 20, 30]
seq1.add(40)
seq1.insert(99, 0)
echo "seq: ", seq1, " len=", len(seq1)
echo "  contains 20? ", 20 in seq1
echo "  filter >15: ", seq1.filterIt(it > 15)
echo "  map *2: ", seq1.mapIt(it * 2)
echo "  sorted: ", sorted(@[3,1,2])

# ---- String as seq[char] ----
var s = "Nim"
s.add("ble")
echo "string: ", s, " reversed: ", s.reversed.join("")

# ---- Tuples ----
let person = (name: "Ada", age: 30, lang: "Nim")
echo "tuple: ", person, " name=", person.name
let (n, a, l) = person
echo &"destructured: {n} {a} {l}"

# Tuple array
let points = @[(1,2), (3,4), (5,6)]
echo "points: ", points

# ---- Tables (HashMap) ----
var capitals = {"Kenya": "Nairobi", "Japan": "Tokyo"}.toTable
capitals["France"] = "Paris"
echo "capitals: ", capitals
echo "  Japan -> ", capitals["Japan"]
echo "  has Kenya? ", capitals.hasKey("Kenya")
for k, v in capitals.pairs:
  echo &"  {k}: {v}"

# OrderedTable preserves insertion order
var ordered = initOrderedTable[string, int]()
ordered["a"]=1; ordered["b"]=2; ordered["c"]=3
echo "orderedTable: ", ordered

# ---- Sets ----
var s1 = [1,2,3].toHashSet
s1.incl(4)
echo "hashSet: ", s1, " contains 3? ", 3 in s1
let s2 = [3,4,5].toHashSet
echo "  union: ", s1 + s2
echo "  intersection: ", s1 * s2
echo "  difference: ", s1 - s2

# CountTable (multiset)
var freq = initCountTable[char]()
for ch in "hello": freq.inc(ch)
echo "freq 'hello': ", freq

# ---- Seq utilities ----
let nums = toSeq(1..10)
echo "1..10 sum: ", nums.foldl(a + b)
echo "1..10 evens: ", nums.filter(x => x mod 2 == 0)
echo "1..10 squares: ", nums.map(x => x*x)[0..2], "..."

# ---- Slicing ----
let slice = nums[2..5]
echo "slice [2..5]: ", slice
echo "nums[^3..^1]: ", nums[^3..^1]
