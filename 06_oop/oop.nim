# oop.nim — inheritance, methods, concepts (interfaces)
# Run: nim c -r 06_oop/oop.nim
import std/strformat, std/sequtils

# ---- Ref object inheritance ----
type
  Animal = ref object of RootObj
    name: string
  Dog = ref object of Animal
    breed: string
  Cat = ref object of Animal

# Dynamic dispatch via `method`
method speak(a: Animal): string {.base.} = "..."
method speak(d: Dog): string = &"Woof! I'm {d.name} the {d.breed}"
method speak(c: Cat): string = &"Meow! I'm {c.name}"

let animals: seq[Animal] = @[
  Dog(name: "Rex", breed: "Labrador"),
  Cat(name: "Whiskers"),
  Dog(name: "Buddy", breed: "Beagle")
]

for a in animals:
  echo speak(a)  # virtual dispatch

# ---- Type checking `of` ----
for a in animals:
  if a of Dog:
    echo &"  -> Dog breed: {Dog(a).breed}"
  elif a of Cat:
    echo "  -> Cat detected"

# ---- Encapsulation via private fields + accessor ----
type Counter = object
  value: int  # normally exported with `value*` if public

proc newCounter(v: int = 0): Counter = Counter(value: v)
proc inc(c: var Counter) = inc c.value
proc get(c: Counter): int = c.value

var cnt = newCounter(10)
cnt.inc()
echo "counter: ", cnt.get()

# ---- Concept — structural interface (Nim's interfaces) ----
type Drawable = concept x
  x.draw() is string

type Circle = object
  r: float
type Square = object
  side: float

proc draw(c: Circle): string = &"Circle r={c.r}"
proc draw(s: Square): string = &"Square side={s.side}"

proc render[T: Drawable](item: T) =
  echo "render: ", item.draw()

render(Circle(r: 5))
render(Square(side: 4))

# ---- Composition over inheritance ----
type Engine = object
  hp: int
type Car = object
  model: string
  engine: Engine

proc drive(c: Car) = echo &"{c.model} drives with {c.engine.hp}hp"

let car = Car(model: "Tesla", engine: Engine(hp: 500))
car.drive()

# ---- Enum dispatch alternative ----
type ShapeKind = enum skCircle, skRect
proc area(kind: ShapeKind, a, b: float): float =
  case kind
  of skCircle: 3.14159 * a * a
  of skRect: a * b
echo "circle area via enum: ", area(skCircle, 5, 0)
