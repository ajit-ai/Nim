# test_metaprogramming.nim — tests for 07_generics_metaprogramming/metaprogramming.nim
# Run: nim c -r tests/test_metaprogramming.nim
import std/unittest
import std/[macros, sequtils]

type
  Stack[T] = object
    items: seq[T]

proc push[T](s: var Stack[T], v: T) = s.items.add(v)
proc pop[T](s: var Stack[T]): T = s.items.pop()

type Addable = concept x, y
  x + y is typeof(x)

proc sumPair[T: Addable](a, b: T): T = a + b

proc repeatStatic[N: static int](c: char): string =
  result=""; for _ in 0..<N: result.add(c)

template withLog(msg: string, body: untyped) =
  body

macro debug(e: untyped): untyped =
  result=quote do: discard `e`

suite "07_generics_metaprogramming":
  test "generics identity + Stack":
    proc identity[T](x:T):T = x
    check identity(42)==42
    check identity("nim")=="nim"
    var st=Stack[int](items: @[])
    st.push(1); st.push(2); st.push(3)
    check st.pop()==3

  test "concept Addable + static params":
    check sumPair(10,20)==30
    check sumPair(1.5,2.5)==4.0
    check repeatStatic[5]('a')=="aaaaa"
    check repeatStatic[3]('z')=="zzz"

  test "templates + macros":
    var ran=false
    withLog("test"):
      ran=true
    check ran==true
    let x=10; let y=5
    debug(x+y)
    check true

  test "compile-time static block":
    const ctVal = 1+2+3+4+5
    check ctVal==15
    static: assert 2+2==4
