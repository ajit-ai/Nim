# objects.nim — object, ref object, enum, distinct, variant
# Run: nim c -r 05_types/objects.nim
import std/[strformat, options, math]

# ---- Objects ----
type
  Person = object
    name: string
    age: int
    email: string

let p = Person(name: "Ada", age: 30, email: "ada@nim.org")
echo &"{p.name} age {p.age} email {p.email}"

# Mutable var object
var p2 = Person(name: "Grace", age: 25, email: "grace@nim.org")
p2.age = 26
echo p2

# ---- Ref object (heap, nullable) ----
type Node = ref object
  value: int
  next: Node

let n1 = Node(value: 1, next: Node(value: 2, next: nil))
echo "node chain: ", n1.value, " -> ", n1.next.value

# ---- Enum ----
type Color = enum
  Red, Green, Blue

var c = Green
echo "color: ", c, " ord=", ord(c)
for col in Color:  # iterable
  echo "  ", col

# Enum with string values
type HttpCode = enum
  Ok = 200, NotFound = 404, ServerError = 500
echo "Ok code: ", ord(Ok), " ", Ok

# ---- Distinct type (type-safe wrapper) ----
type Dollars = distinct int
type Euros = distinct int

proc `$`(d: Dollars): string = &"${d.int}"
proc `$`(e: Euros): string = &"€{e.int}"

let d: Dollars = 100.Dollars
let e: Euros = 100.Euros
echo d, " vs ", e
# echo d + e  # compile error! different distinct types
echo "Dollars + Dollars: ", (d.int + 20.Dollars.int).Dollars

# ---- Variant object (tagged union / discriminated) ----
type
  ShapeKind = enum skCircle, skRect
  Shape = object
    case kind: ShapeKind
    of skCircle: radius: float
    of skRect: width, height: float

let circle = Shape(kind: skCircle, radius: 5.0)
let rect = Shape(kind: skRect, width: 4.0, height: 3.0)

proc area(s: Shape): float =
  case s.kind
  of skCircle: 3.14159 * s.radius * s.radius
  of skRect: s.width * s.height

echo &"circle area: {area(circle):.2f}"
echo &"rect area: {area(rect):.2f}"

# ---- Option (std/options) ----
let someVal = some(42)
let noneVal: Option[int] = none(int)
echo "some: ", someVal, " isSome=", someVal.isSome
echo "none isSome=", noneVal.isSome
echo "getOrDefault: ", noneVal.get(0)

# ---- Tuple vs Object ----
type Vec2 = tuple[x, y: float]
let v: Vec2 = (3.0, 4.0)
echo &"vec len: {(v.x*v.x + v.y*v.y).sqrt:.2f}"
