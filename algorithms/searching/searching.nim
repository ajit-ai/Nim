# searching.nim — linear, binary, BFS-style search demos
# Run: nim c -r algorithms/searching/searching.nim
import std/[sequtils, algorithm, strformat, math]

proc linearSearch[T](a: seq[T], x: T): int =
  # O(n) — unsorted okay
  for i, v in a:
    if v == x: return i
  return -1

proc binarySearch[T](a: seq[T], x: T): int =
  # O(log n) — requires sorted
  var lo = 0; var hi = a.len - 1
  while lo <= hi:
    let mid = (lo + hi) div 2
    if a[mid] == x: return mid
    elif a[mid] < x: lo = mid + 1
    else: hi = mid - 1
  return -1

let arr = @[2,5,8,12,16,23,38,56,72,91]
echo "sorted arr: ", arr
echo "linear 23 -> idx ", linearSearch(arr, 23), " (O(n))"
echo "binary 23 -> idx ", binarySearch(arr, 23), " (O(log n))"
echo "binary 100 -> ", binarySearch(arr, 100), " (not found -1)"

# Generic searchable via sequtils
echo "contains 16? ", arr.contains(16)

# Lower/upper bound (binary search variants)
proc lowerBound[T](a: seq[T], x: T): int =
  var lo=0; var hi=a.len
  while lo < hi:
    let mid = (lo + hi) div 2
    if a[mid] < x: lo = mid + 1 else: hi = mid
  lo

echo "lowerBound 20 in arr -> ", lowerBound(arr, 20), " value=", arr[lowerBound(arr,20)]

# String search (substring) - O(n*m) naive
proc naiveSearch(text, pat: string): int =
  for i in 0..text.len - pat.len:
    var ok = true
    for j in 0..<pat.len:
      if text[i+j] != pat[j]: ok=false; break
    if ok: return i
  -1

let text = "nimble is nim-friendly"
let pat = "nim"
echo &"naiveSearch 'nim' in '{text}' -> {naiveSearch(text, pat)}"

# Jump search (for educational)
proc jumpSearch(a: seq[int], x: int): int =
  let n = a.len; let step = int(sqrt(float(n)))
  var prev = 0
  var cur = step
  while a[min(cur, n) - 1] < x:
    prev = cur; cur += step
    if prev >= n: return -1
  for i in prev ..< min(cur, n):
    if a[i] == x: return i
  -1

echo "jumpSearch 38 -> ", jumpSearch(arr, 38)
