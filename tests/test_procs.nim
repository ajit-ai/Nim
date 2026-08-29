# test_procs.nim — tests for 03_procedures/procs.nim + closures_hof.nim
# Run: nim c -r tests/test_procs.nim
import std/unittest
import std/[sequtils, math, algorithm, sugar]

suite "03_procedures/procs.nim":
  test "greet + power default args":
    proc greet(name: string): string = "Hello, " & name & "!"
    check greet("Ada") == "Hello, Ada!"
    proc power(base, exp: float = 2.0): float = pow(base, exp)
    check power(3) == 9.0
    check power(2, 8) == 256.0

  test "overloading":
    proc add(a,b:int):int = a+b
    proc add(a,b:float):float = a+b
    proc add(a,b,c:int):int = a+b+c
    check add(2,3)==5
    check add(2.5,3.1)==5.6
    check add(1,2,3)==6

  test "var params + pure func + recursion":
    proc incVar(x: var int) = inc x
    var n=10; incVar(n); check n==11
    func pureAdd(a,b:int):int = a+b
    check pureAdd(5,7)==12
    proc factorial(n:int):int = (if n<=1:1 else: n*factorial(n-1))
    check factorial(5)==120
    proc divmod(a,b:int):(int,int) = (a div b, a mod b)
    check divmod(17,5)==(3,2)

  test "higher-order + anonymous":
    proc applyTwice(f: proc(x:int):int, x:int):int = f(f(x))
    proc double(x:int):int = x*2
    check applyTwice(double,3)==12
    let square = proc(x:int):int = x*x
    check square(6)==36

suite "03_procedures/closures_hof.nim":
  test "closure counter + makeAdder":
    proc makeCounter(start:int): proc():int =
      var count=start
      result=proc():int = result=count; inc count
    let c=makeCounter(10)
    check c()==10; check c()==11; check c()==12
    proc makeAdder(n:int): proc(x:int):int = return proc(x:int):int = x+n
    check makeAdder(5)(10)==15

  test "HOF map/filter/fold + gcd/fib":
    let nums = @[1,2,3,4,5]
    check nums.map(x=>x*2)== @[2,4,6,8,10]
    check nums.filter(x=>x mod 2==0)== @[2,4]
    check nums.foldl(a+b)==15
    proc gcd(a,b:int):int = (if b==0:a else: gcd(b, a mod b))
    check gcd(48,18)==6

  test "sorting with custom comparator":
    var words = @["nim","python","go","rust"]
    words.sort((x,y)=>cmp(x.len, y.len))
    check words[0]=="go"  # shortest
