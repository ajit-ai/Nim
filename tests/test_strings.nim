# test_strings.nim — tests for algorithms/strings/strings.nim
# Run: nim c -r tests/test_strings.nim
import std/unittest
import std/[strutils, tables, algorithm, sequtils]

proc isPalindrome(s: string): bool =
  var i=0; var j=s.len-1
  while i<j:
    if s[i].toLowerAscii != s[j].toLowerAscii: return false
    inc i; dec j
  true

proc isAnagram(a,b: string): bool =
  if a.len != b.len: return false
  var freq=initCountTable[char]()
  for c in a.toLowerAscii: freq.inc(c)
  for c in b.toLowerAscii: freq.inc(c, -1)
  for _, v in freq:
    if v != 0: return false
  true

proc kmpPrefix(pat: string): seq[int] =
  result=newSeq[int](pat.len)
  var j=0
  for i in 1..<pat.len:
    while j>0 and pat[i]!=pat[j]: j=result[j-1]
    if pat[i]==pat[j]: inc j
    result[i]=j

proc kmpSearch(text, pat: string): int =
  if pat.len==0: return 0
  let lps=kmpPrefix(pat)
  var j=0
  for i in 0..<text.len:
    while j>0 and text[i]!=pat[j]: j=lps[j-1]
    if text[i]==pat[j]: inc j
    if j==pat.len: return i-pat.len+1
  -1

proc longestPal(s: string): string =
  var best=""
  for center in 0..<s.len:
    for dir in [0,1]:
      var l=center; var r=center+dir
      while l>=0 and r<s.len and s[l]==s[r]:
        if r-l+1 > best.len: best=s[l..r]
        dec l; inc r
  best

proc rle(s: string): string =
  if s.len==0: return ""
  var c=1
  result= $s[0]
  for i in 1..<s.len:
    if s[i]==s[i-1]: inc c
    else:
      result.add($c & s[i])
      c=1
  result.add($c)

proc wc(s: string): Table[string,int] =
  for w in s.splitWhitespace():
    let k=w.toLowerAscii
    result[k]=result.getOrDefault(k,0)+1

suite "algorithms/strings":
  test "palindrome":
    check isPalindrome("Racecar")==true
    check isPalindrome("nim")==false
    check isPalindrome("a")==true
    check isPalindrome("")==true
  test "anagram":
    check isAnagram("listen","silent")==true
    check isAnagram("hello","world")==false
    check isAnagram("Dormitory".toLowerAscii,"Dirtyroom".toLowerAscii)==true
  test "KMP":
    check kmpSearch("ababcababcabc","abcabc")==7
    check kmpSearch("hello","ll")==2
    check kmpSearch("abc","d")== -1
    check kmpSearch("abc","")==0
    check kmpSearch("nimble","nim")== "nimble".find("nim")
  test "longest palindrome":
    check longestPal("babad").len==3
    check longestPal("babad") in ["bab","aba"]
    check longestPal("cbbd")=="bb"
  test "RLE + wordCount":
    check rle("aaabbc")=="a3b2c1"
    check wc("hello hello Nim".toLowerAscii)["hello"]==2
