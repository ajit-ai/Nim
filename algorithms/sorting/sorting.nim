# sorting.nim — bubble, insertion, selection, quick, merge, heap (with complexity)
# Run: nim c -r algorithms/sorting/sorting.nim
import std/[sequtils, algorithm, strformat]

proc bubbleSort(a: var seq[int]) =
  # O(n^2) stable, adaptive
  for i in 0..<a.len:
    for j in 0..<a.len-1-i:
      if a[j] > a[j+1]: swap(a[j], a[j+1])

proc insertionSort(a: var seq[int]) =
  # O(n^2) stable, good for small/nearly sorted
  for i in 1..<a.len:
    let key = a[i]
    var j = i-1
    while j >= 0 and a[j] > key:
      a[j+1] = a[j]; dec j
    a[j+1] = key

proc selectionSort(a: var seq[int]) =
  # O(n^2) unstable
  for i in 0..<a.len:
    var minIdx = i
    for j in i+1..<a.len:
      if a[j] < a[minIdx]: minIdx = j
    swap(a[i], a[minIdx])

proc quickSort(a: var seq[int], lo=0, hi= -1) =
  # O(n log n) avg, O(n^2) worst; unstable
  var hiVar = if hi == -1: a.len-1 else: hi
  if lo >= hiVar: return
  var i = lo; var j = hiVar; let pivot = a[(lo+hiVar) div 2]
  while i <= j:
    while a[i] < pivot: inc i
    while a[j] > pivot: dec j
    if i <= j: swap(a[i], a[j]); inc i; dec j
  if lo < j: quickSort(a, lo, j)
  if i < hiVar: quickSort(a, i, hiVar)

proc merge(a, b: seq[int]): seq[int] =
  var i=0; var j=0
  while i < a.len and j < b.len:
    if a[i] <= b[j]: result.add(a[i]); inc i
    else: result.add(b[j]); inc j
  while i < a.len: result.add(a[i]); inc i
  while j < b.len: result.add(b[j]); inc j

proc mergeSort(a: seq[int]): seq[int] =
  # O(n log n) stable, needs O(n) extra
  if a.len <= 1: return a
  let mid = a.len div 2
  merge(mergeSort(a[0..<mid]), mergeSort(a[mid..^1]))

# Heap via std/algorithm (built-in)Demo
proc demoSort(name: string, data: seq[int], sorter: proc(a: var seq[int])) =
  var copy = data
  sorter(copy)
  echo &"{name}: {copy} (sorted? {copy == sorted(data)})"

let data = @[64, 34, 25, 12, 22, 11, 90]

demoSort("bubble   ", data, bubbleSort)
demoSort("insertion", data, insertionSort)
demoSort("selection", data, selectionSort)

var qData = data
quickSort(qData)
echo &"quick    : {qData}"

echo &"merge    : {mergeSort(data)}"

var hData = data
hData.sort()  # Nim's introsort (heap/quick/insert hybrid) O(n log n)
echo &"std sort : {hData}"

# Benchmark-ish: large seq
let large = toSeq(countdown(1000, 1))  # reverse 1000..1
var t = large
bubbleSort(t)  # slow for 1000
echo "bubble 1000..1 sorted? ", t == toSeq(1..1000)
