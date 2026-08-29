# test_math.nim — tests for algorithms/math/math.nim
# Run: nim c -r tests/test_math.nim
import std/unittest
import std/[sequtils, math, algorithm]

proc gcd(a,b: int): int =
  if b==0: abs(a) else: gcd(b, a mod b)

proc lcm(a,b: int): int = abs(a div gcd(a,b) * b)

proc fastPow(base, exp: int): int =
  if exp==0: return 1
  if exp mod 2==0:
    let h=fastPow(base, exp div 2)
    return h*h
  base*fastPow(base, exp-1)

proc sieve(n: int): seq[int] =
  if n<2: return @[]
  var isPrime=newSeq[bool](n+1)
  for i in 0..<isPrime.len: isPrime[i]=true
  isPrime[0]=false
  if n>=1: isPrime[1]=false
  for i in 2..int(sqrt(float(n))):
    if isPrime[i]:
      for j in countup(i*i, n, i): isPrime[j]=false
  for i in 2..n:
    if isPrime[i]: result.add(i)

proc isPrime(n: int): bool =
  if n<2: return false
  if n mod 2==0: return n==2
  for i in countup(3, int(sqrt(float(n))), 2):
    if n mod i==0: return false
  true

proc factorize(n: int): seq[int] =
  var x=n; var d=2
  while d*d <= x:
    while x mod d==0:
      result.add(d); x=x div d
    inc d
  if x>1: result.add(x)

proc modPow(base, exp, m: int): int =
  result=1
  var b=base mod m; var e=exp
  while e>0:
    if (e and 1)==1: result=(result*b) mod m
    b=(b*b) mod m; e=e shr 1

proc nCr(n,r: int): int =
  if r<0 or r>n: return 0
  var r = min(r, n-r)
  result=1
  for i in 0..<r:
    result=result*(n-i) div (i+1)

proc factIter(n: int): int =
  result=1
  for i in 2..n: result*=i

suite "algorithms/math":
  test "gcd/lcm":
    check gcd(48,18)==6
    check lcm(4,6)==12
    check gcd(0,5)==5
    check gcd(-12,8)==4
  test "factorial + fastPow":
    check factIter(5)==120
    check fastPow(2,10)==1024
    check fastPow(3,5)==243
    check modPow(2,10,1000)==24
  test "sieve + isPrime":
    check sieve(30)== @[2,3,5,7,11,13,17,19,23,29]
    check isPrime(17)==true
    check isPrime(18)==false
    check isPrime(2)==true
    check isPrime(1)==false
  test "factorize":
    check factorize(84)== @[2,2,3,7]
    check factorize(13)== @[13]
    check factorize(60)== @[2,2,3,5]
  test "nCr":
    check nCr(5,2)==10
    check nCr(10,3)==120
    check nCr(5,0)==1
    check nCr(5,6)==0
