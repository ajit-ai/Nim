# test_dp.nim — tests for algorithms/dynamic_programming/dp.nim
# Run: nim c -r tests/test_dp.nim
import std/unittest
import std/[sequtils, algorithm]

proc fibIter(n: int): int =
  if n <= 1: return n
  var a=0; var b=1
  for _ in 2..n:
    let c=a+b
    a=b
    b=c
  b

proc knapsack(weights, values: seq[int], W: int): int =
  var dp=newSeq[int](W+1)
  for i in 0..<weights.len:
    for w in countdown(W, weights[i]):
      dp[w]=max(dp[w], dp[w-weights[i]]+values[i])
  dp[W]

proc lcs(a,b: string): string =
  let n=a.len; let m=b.len
  var dp=newSeq[seq[int]](n+1)
  for i in 0..n: dp[i]=newSeq[int](m+1)
  for i in 1..n:
    for j in 1..m:
      if a[i-1]==b[j-1]: dp[i][j]=dp[i-1][j-1]+1
      else: dp[i][j]=max(dp[i-1][j], dp[i][j-1])
  var i=n; var j=m; var res=""
  while i>0 and j>0:
    if a[i-1]==b[j-1]:
      res=a[i-1] & res; dec i; dec j
    elif dp[i-1][j] > dp[i][j-1]: dec i
    else: dec j
  res

proc minCoins(coins: seq[int], amount: int): int =
  var dp=newSeq[int](amount+1)
  for i in 0..dp.len-1: dp[i]=high(int) div 2
  dp[0]=0
  for c in coins:
    for a in c..amount: dp[a]=min(dp[a], dp[a-c]+1)
  if dp[amount] >= high(int) div 2: -1 else: dp[amount]

proc countWays(coins: seq[int], amount: int): int =
  var dp=newSeq[int](amount+1); dp[0]=1
  for c in coins:
    for a in c..amount: dp[a]+=dp[a-c]
  dp[amount]

proc editDistance(a,b: string): int =
  var dp=newSeq[seq[int]](a.len+1)
  for i in 0..a.len: dp[i]=newSeq[int](b.len+1)
  for i in 0..a.len: dp[i][0]=i
  for j in 0..b.len: dp[0][j]=j
  for i in 1..a.len:
    for j in 1..b.len:
      let cost= if a[i-1]==b[j-1]:0 else:1
      dp[i][j]=min([dp[i-1][j]+1, dp[i][j-1]+1, dp[i-1][j-1]+cost])
  dp[a.len][b.len]

suite "algorithms/dp":
  test "fib iterates":
    check fibIter(0)==0
    check fibIter(1)==1
    check fibIter(10)==55
    check fibIter(15)==610
  test "knapsack":
    check knapsack(@[1,3,4,5],@[1,4,5,7],7)==9
    check knapsack(@[2,3],@[3,4],5)==7
    check knapsack(@[10],@[100],5)==0
  test "LCS":
    let r=lcs("ABCBDAB","BDCAB")
    check r.len==4
    check r in ["BCAB","BDAB"]
    check lcs("ABC","ABC")=="ABC"
    check lcs("ABC","DEF")==""
  test "coin change":
    check minCoins(@[1,2,5],11)==3
    check minCoins(@[2],3)== -1
    check countWays(@[1,2,5],5)==4
    check countWays(@[1],5)==1
  test "edit distance":
    check editDistance("kitten","sitting")==3
    check editDistance("","abc")==3
    check editDistance("abc","abc")==0
