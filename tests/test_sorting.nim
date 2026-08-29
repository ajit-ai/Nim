# test_sorting.nim — tests for algorithms/sorting/sorting.nim
# Run: nim c -r tests/test_sorting.nim
import std/unittest
import std/[sequtils, algorithm, strformat]

proc bubbleSort(a: var seq[int]) =
  for i in 0..<a.len:
    for j in 0..<a.len-1-i:
      if a[j]>a[j+1]: swap(a[j],a[j+1])
proc insertionSort(a: var seq[int]) =
  for i in 1..<a.len:
    let key=a[i]; var j=i-1
    while j>=0 and a[j]>key: a[j+1]=a[j]; dec j
    a[j+1]=key
proc selectionSort(a: var seq[int]) =
  for i in 0..<a.len:
    var minIdx=i
    for j in i+1..<a.len:
      if a[j]<a[minIdx]: minIdx=j
    swap(a[i], a[minIdx])
proc quickSort(a: var seq[int], lo=0, hi= -1) =
  var hiVar= if hi == -1: a.len-1 else: hi
  if lo>=hiVar: return
  var i=lo; var j=hiVar; let pivot=a[(lo+hiVar) div 2]
  while i<=j:
    while a[i]<pivot: inc i
    while a[j]>pivot: dec j
    if i<=j: swap(a[i],a[j]); inc i; dec j
  if lo<j: quickSort(a, lo,j)
  if i<hiVar: quickSort(a, i,hiVar)
proc merge(a,b: seq[int]): seq[int] =
  var i=0; var j=0
  while i<a.len and j<b.len:
    if a[i]<=b[j]: result.add(a[i]); inc i else: result.add(b[j]); inc j
  while i<a.len: result.add(a[i]); inc i
  while j<b.len: result.add(b[j]); inc j
proc mergeSort(a: seq[int]): seq[int] =
  if a.len<=1: return a
  let mid=a.len div 2
  merge(mergeSort(a[0..<mid]), mergeSort(a[mid..^1]))

suite "algorithms/sorting":
  let cases = @[
    @[64,34,25,12,22,11,90],
    @[5,4,3,2,1],
    @[1],
    @[],
    @[2,2,2],
    @[1,3,2,3,1]
  ]
  test "bubble": 
    for c in cases:
      var v=c; bubbleSort(v); check v==sorted(c)
  test "insertion":
    for c in cases:
      var v=c; insertionSort(v); check v==sorted(c)
  test "selection":
    for c in cases:
      var v=c; selectionSort(v); check v==sorted(c)
  test "quick":
    for c in cases:
      var v=c; quickSort(v); check v==sorted(c)
  test "merge functional":
    for c in cases:
      check mergeSort(c)==sorted(c)
  test "std sort + large":
    check mergeSort(toSeq(countdown(1000,1)))==toSeq(1..1000)
