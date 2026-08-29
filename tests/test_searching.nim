# test_searching.nim — tests for algorithms/searching/searching.nim
# Run: nim c -r tests/test_searching.nim
import std/unittest

proc linearSearch[T](a: seq[T], x: T): int =
  for i, v in a:
    if v == x: return i
  -1

proc binarySearch[T](a: seq[T], x: T): int =
  var lo=0; var hi=a.len-1
  while lo <= hi:
    let mid=(lo+hi) div 2
    if a[mid]==x: return mid
    elif a[mid]<x: lo=mid+1 else: hi=mid-1
  -1

proc lowerBound[T](a: seq[T], x: T): int =
  var lo=0; var hi=a.len
  while lo < hi:
    let mid=(lo+hi) div 2
    if a[mid] < x: lo=mid+1 else: hi=mid
  lo

proc naiveSearch(text, pat: string): int =
  for i in 0..text.len-pat.len:
    var ok=true
    for j in 0..<pat.len:
      if text[i+j] != pat[j]:
        ok=false
        break
    if ok: return i
  -1

suite "algorithms/searching":
  let arr = @[2,5,8,12,16,23,38,56,72,91]
  test "linear":
    check linearSearch(arr,23)==5
    check linearSearch(arr,100)== -1
    check linearSearch(arr,2)==0
  test "binary sorted":
    check binarySearch(arr,23)==5
    check binarySearch(arr,100)== -1
    check binarySearch(arr,2)==0
    check binarySearch(arr,91)==9
    for v in arr: check binarySearch(arr,v)==linearSearch(arr,v)
  test "lowerBound":
    check lowerBound(arr,20)==5
    check lowerBound(arr,2)==0
    check lowerBound(arr,100)==10
  test "naiveSearch substring":
    check naiveSearch("nimble is nim-friendly","nim")==0
    check naiveSearch("hello","ll")==2
    check naiveSearch("abc","d")== -1
