# test_exceptions.nim — tests for 08_error_handling/exceptions.nim
# Run: nim c -r tests/test_exceptions.nim
import std/unittest
import std/[options, strutils]

suite "08_error_handling":
  test "custom exception + try/except":
    type AppError = object of CatchableError
      code:int
    proc risky(val:int):int =
      if val<0: raise newException(AppError, "negative")
      if val==0: raise newException(ValueError, "zero")
      100 div val
    expect AppError: discard risky(-5)
    expect ValueError: discard risky(0)
    check risky(5)==20

  test "defer LIFO order":
    var order: seq[string]
    proc withDefer() =
      defer: order.add("cleanup1")
      defer: order.add("cleanup2")
      order.add("work")
    withDefer()
    check order== @["work","cleanup2","cleanup1"]

  test "Option findEven":
    proc findEven(nums: seq[int]): Option[int] =
      for n in nums:
        if n mod 2==0: return some(n)
      none(int)
    check findEven(@[1,3,5]).isNone
    check findEven(@[1,2,3]).get()==2
    check findEven(@[1,3,5]).get(999)==999

  test "Result pattern + parseOrDefault":
    type Result[T,E] = object
      case ok:bool
      of true: value:T
      of false: error:E
    proc ok[T,E](v:T):Result[T,E] = Result[T,E](ok:true, value:v)
    proc err[T,E](e:E):Result[T,E] = Result[T,E](ok:false, error:e)
    proc safeDiv(a,b:int):Result[int,string] =
      if b==0: err[int,string]("zero") else: ok[int,string](a div b)
    check safeDiv(10,2).value==5
    check not safeDiv(10,0).ok
    proc parseOrDefault(s:string, def:int):int =
      try: parseInt(s) except ValueError: def
    check parseOrDefault("abc", -1)== -1
    check parseOrDefault("123", -1)==123
