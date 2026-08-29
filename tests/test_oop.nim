# test_oop.nim — tests for 06_oop/oop.nim
# Run: nim c -r tests/test_oop.nim
import std/unittest
import std/strformat

type
  Animal = ref object of RootObj
    name: string
  Dog = ref object of Animal
    breed: string
  Cat = ref object of Animal

method speak(a: Animal): string {.base.} = "..."
method speak(d: Dog): string = "Woof! " & d.name
method speak(c: Cat): string = "Meow! " & c.name

type
  Counter = object
    value: int
proc newCounter(v:int=0): Counter = Counter(value:v)
proc inc(c: var Counter) = inc c.value
proc get(c: Counter): int = c.value

type
  Drawable = concept x
    x.draw() is string
  Circle = object
    r: float
  Square = object
    side: float
  Engine = object
    hp: int
  Car = object
    model: string
    engine: Engine

proc draw(c: Circle): string = "Circle"
proc draw(s: Square): string = "Square"
proc isDrawable[T: Drawable](x: T): bool = true

suite "06_oop/oop.nim":
  test "method dispatch + of check":
    let animals: seq[Animal] = @[Dog(name:"Rex", breed:"Lab"), Cat(name:"Whiskers")]
    check speak(animals[0])=="Woof! Rex"
    check speak(animals[1])=="Meow! Whiskers"
    check (animals[0] of Dog)
    check (animals[1] of Cat)
    check Dog(animals[0]).breed=="Lab"

  test "encapsulation counter":
    var cnt=newCounter(10)
    cnt.inc(); check cnt.get()==11

  test "concept Drawable + composition":
    check isDrawable(Circle(r:5))
    check isDrawable(Square(side:4))
    let car=Car(model:"Tesla", engine:Engine(hp:500))
    check car.engine.hp==500
