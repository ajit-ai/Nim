# test_types.nim — tests for 05_types/objects.nim
# Run: nim c -r tests/test_types.nim
import std/unittest
import std/[options, strformat]

type
  Person = object
    name: string
    age: int
    email: string
  Node = ref object
    value: int
    next: Node
  Color = enum
    Red, Green, Blue
  Dollars = distinct int
  ShapeKind = enum
    skCircle, skRect
  Shape = object
    case kind: ShapeKind
    of skCircle:
      radius: float
    of skRect:
      width, height: float

proc area(s: Shape): float =
  case s.kind
  of skCircle: 3.14159*s.radius*s.radius
  of skRect: s.width*s.height

suite "05_types/objects.nim":
  test "object + mutable":
    let p=Person(name:"Ada",age:30,email:"ada@nim.org")
    check p.name=="Ada" and p.age==30
    var p2=Person(name:"Grace",age:25,email:"grace@nim.org")
    p2.age=26; check p2.age==26

  test "ref object chain":
    let n1=Node(value:1, next:Node(value:2, next:nil))
    check n1.value==1
    check n1.next.value==2
    check n1.next.next==nil

  test "enum iteration + distinct":
    check ord(Green)==1
    var count=0; for col in Color: inc count
    check count==3
    let d: Dollars = 100.Dollars
    check d.int==100

  test "variant object area":
    let circle=Shape(kind:skCircle, radius:5.0)
    let rect=Shape(kind:skRect, width:4.0, height:3.0)
    check abs(area(circle)-78.53975) < 0.001
    check area(rect)==12.0

  test "Option":
    let someVal=some(42)
    let noneVal: Option[int]=none(int)
    check someVal.isSome and someVal.get()==42
    check not noneVal.isSome
    check noneVal.get(0)==0
