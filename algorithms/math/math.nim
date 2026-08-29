# math.nim — gcd, lcm, sieve, factorial, prime, fast pow, fibonacci
# Run: nim c -r algorithms/math/math.nim
import std/[strformat, sequtils, math, algorithm]

proc gcd(a,b: int): int =
  if b==0: abs(a) else: gcd(b, a mod b)
proc lcm(a,b: int): int = abs(a div gcd(a,b) * b)
echo "gcd(48,18)= ", gcd(48,18), " lcm(4,6)= ", lcm(4,6)

proc factorial(n: int): int =
  if n<=1: 1 else: n * factorial(n-1)
echo "factorial(5)= ", factorial(5), " iter 10! = ", (1..10).toSeq.foldl(a*b)

# Iterative factorial to avoid recursion limit
proc factIter(n: int): int =
  result=1; for i in 2..n: result*=i
echo "factIter(12)= ", factIter(12)

# Fast power O(log n)
proc fastPow(base, exp: int): int =
  if exp==0: return 1
  if exp mod 2==0:
    let half=fastPow(base, exp div 2)
    return half*half
  base * fastPow(base, exp-1)
echo "fastPow(2,10)= ", fastPow(2,10), " pow(3,5)= ", fastPow(3,5)

# Sieve of Eratosthenes
proc sieve(n: int): seq[int] =
  var isPrime = newSeq[bool](n+1)
  isPrime.fill(true); isPrime[0]=false
  if n>=1: isPrime[1]=false
  for i in 2..int(sqrt(float(n))):
    if isPrime[i]:
      for j in countup(i*i, n, i): isPrime[j]=false
  for i in 2..n:
    if isPrime[i]: result.add(i)

echo "primes <=30: ", sieve(30)

proc isPrime(n: int): bool =
  if n<2: return false
  if n mod 2==0: return n==2
  for i in countup(3, int(sqrt(float(n))), 2):
    if n mod i==0: return false
  true
echo "isPrime 17? ", isPrime(17), " 18? ", isPrime(18)

# Fibonacci variants
proc fibRec(n:int): int =
  if n<2: n else: fibRec(n-1)+fibRec(n-2)
echo "fibRec(8)= ", fibRec(8)

# Prime factorization
proc factorize(n: int): seq[int] =
  var x=n; var d=2
  while d*d <= x:
    while x mod d==0: result.add(d); x = x div d
    inc d
  if x>1: result.add(x)
echo "factorize(84)= ", factorize(84), " (2*2*3*7)"

# Modular arithmetic
proc modPow(base, exp, m: int): int =
  result=1; var b=base mod m; var e=exp
  while e>0:
    if (e and 1)==1: result=(result*b) mod m
    b=(b*b) mod m; e=e shr 1
echo "modPow(2,10,1000)= ", modPow(2,10,1000)

# Combinatorics nCr
proc nCr(n, r: int): int =
  if r<0 or r>n: return 0
  var r = min(r, n-r)
  result=1
  for i in 0..<r:
    result = result * (n-i) div (i+1)
echo "nCr(5,2)= ", nCr(5,2), " nCr(10,3)= ", nCr(10,3)
