# dp.nim — fibonacci, knapsack, LCS, coin change
# Run: nim c -r algorithms/dynamic_programming/dp.nim
import std/[strformat, sequtils, algorithm]

# Fibonacci memoized O(n)
proc fib(n: int, memo: var seq[int]): int =
  if n <= 1: return n
  if memo[n] != -1: return memo[n]
  memo[n] = fib(n-1, memo) + fib(n-2, memo)
  memo[n]

var memo = newSeq[int](20); memo.fill(-1)
echo "fib(10) memoized = ", fib(10, memo)

# Fibonacci bottom-up O(n) O(1) space
proc fibIter(n: int): int =
  if n <= 1: return n
  var a=0; var b=1
  for _ in 2..n:
    let c=a+b; a=b; b=c
  b
echo "fibIter(10) = ", fibIter(10)

# 0/1 Knapsack O(n*W)
proc knapsack(weights, values: seq[int], W: int): int =
  var dp = newSeq[int](W+1)
  for i in 0..<weights.len:
    for w in countdown(W, weights[i]):
      dp[w] = max(dp[w], dp[w-weights[i]] + values[i])
  dp[W]

let w = @[1,3,4,5]; let v = @[1,4,5,7]; let cap=7
echo &"knapsack W=7 weights={w} values={v} -> max={knapsack(w,v,cap)} (expect 9)"

# Longest Common Subsequence O(n*m)
proc lcs(a,b: string): string =
  let n=a.len; let m=b.len
  var dp = newSeq[seq[int]](n+1)
  for i in 0..n: dp[i]=newSeq[int](m+1)
  for i in 1..n:
    for j in 1..m:
      if a[i-1]==b[j-1]: dp[i][j]=dp[i-1][j-1]+1
      else: dp[i][j]=max(dp[i-1][j], dp[i][j-1])
  # backtrack
  var i=n; var j=m; var res=""
  while i>0 and j>0:
    if a[i-1]==b[j-1]: res = a[i-1] & res; dec i; dec j
    elif dp[i-1][j] > dp[i][j-1]: dec i else: dec j
  res

echo &"LCS('ABCBDAB','BDCAB') = '{lcs(\"ABCBDAB\",\"BDCAB\")}' (expect 'BCAB' or 'BDAB')"

# Coin change: min coins O(n*amount) + count ways
proc minCoins(coins: seq[int], amount: int): int =
  var dp = newSeq[int](amount+1)
  dp.fill(high(int) div 2); dp[0]=0
  for c in coins:
    for a in c..amount:
      dp[a] = min(dp[a], dp[a-c]+1)
  if dp[amount] >= high(int) div 2: -1 else: dp[amount]

echo "minCoins [1,2,5] amount 11 -> ", minCoins(@[1,2,5], 11), " (expect 3: 5+5+1)"

proc countWays(coins: seq[int], amount: int): int =
  var dp = newSeq[int](amount+1); dp[0]=1
  for c in coins:
    for a in c..amount: dp[a] += dp[a-c]
  dp[amount]

echo "countWays [1,2,5] amount 5 -> ", countWays(@[1,2,5], 5), " (expect 4)"

# Edit distance (Levenshtein)
proc editDistance(a,b: string): int =
  var dp = newSeq[seq[int]](a.len+1)
  for i in 0..a.len: dp[i]=newSeq[int](b.len+1)
  for i in 0..a.len: dp[i][0]=i
  for j in 0..b.len: dp[0][j]=j
  for i in 1..a.len:
    for j in 1..b.len:
      let cost = if a[i-1]==b[j-1]: 0 else: 1
      dp[i][j]=min([dp[i-1][j]+1, dp[i][j-1]+1, dp[i-1][j-1]+cost])
  dp[a.len][b.len]

echo "editDistance 'kitten'->'sitting' = ", editDistance("kitten","sitting"), " (expect 3)"
