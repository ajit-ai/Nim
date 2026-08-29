# strings.nim — palindrome, anagram, reverse, KMP
# Run: nim c -r algorithms/strings/strings.nim
import std/[strutils, sequtils, strformat, tables, algorithm]

proc isPalindrome(s: string): bool =
  var i=0; var j=s.len-1
  while i<j:
    if s[i].toLowerAscii != s[j].toLowerAscii: return false
    inc i; dec j
  true
echo "isPalindrome 'Racecar'? ", isPalindrome("Racecar")
echo "isPalindrome 'nim'? ", isPalindrome("nim")

proc reverseStr(s: string): string = s.reversed.join("")
echo "reverse 'nimble' -> ", reverseStr("nimble")

proc isAnagram(a,b: string): bool =
  if a.len != b.len: return false
  var freq = initCountTable[char]()
  for c in a.toLowerAscii: freq.inc(c)
  for c in b.toLowerAscii: freq.inc(c, -1)
  for _, v in freq:
    if v != 0: return false
  true

echo "isAnagram 'listen','silent'? ", isAnagram("listen","silent")
echo "isAnagram 'hello','world'? ", isAnagram("hello","world")

# KMP prefix function + search O(n+m)
proc kmpPrefix(pat: string): seq[int] =
  result = newSeq[int](pat.len)
  var j=0
  for i in 1..<pat.len:
    while j>0 and pat[i]!=pat[j]: j=result[j-1]
    if pat[i]==pat[j]: inc j
    result[i]=j

proc kmpSearch(text, pat: string): int =
  if pat.len==0: return 0
  let lps = kmpPrefix(pat)
  var j=0
  for i in 0..<text.len:
    while j>0 and text[i]!=pat[j]: j=lps[j-1]
    if text[i]==pat[j]: inc j
    if j==pat.len: return i - pat.len + 1
  -1

let txt = "ababcababcabc"
let pat = "abcabc"
echo &"KMP '{pat}' in '{txt}' -> {kmpSearch(txt, pat)}"
echo "  brute find: ", txt.find(pat)

# Longest palindrome substring (expand around center O(n^2))
proc longestPal(s: string): string =
  var best=""
  for center in 0..<s.len:
    for dir in [0,1]:  # 0 odd, 1 even
      var l=center; var r=center+dir
      while l>=0 and r<s.len and s[l]==s[r]:
        if r-l+1 > best.len: best=s[l..r]
        dec l; inc r
  best

echo "longestPal 'babad' -> ", longestPal("babad")
echo "longestPal 'cbbd' -> ", longestPal("cbbd")

# Word count
proc wordCount(s: string): Table[string,int] =
  for w in s.splitWhitespace():
    let k=w.toLowerAscii.strip(chars={' ',',','.'})
    if k.len>0: result[k]=result.getOrDefault(k,0)+1

echo "wordCount 'hello hello Nim' -> ", wordCount("hello hello Nim")

# Compress (RLE)
proc rle(s: string): string =
  if s.len==0: return ""
  var count=1; result= $s[0]
  for i in 1..<s.len:
    if s[i]==s[i-1]: inc count
    else: result.add($count & s[i]); count=1
  result.add($count)

echo "RLE 'aaabbc' -> ", rle("aaabbc"), " (expect a3b2c1)"
