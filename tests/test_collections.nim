# test_collections.nim — tests for 04_collections/collections.nim
# Run: nim c -r tests/test_collections.nim
import std/unittest
import std/[tables, sets, sequtils, strutils, algorithm, sugar]

suite "04_collections":
  test "array static":
    var arr: array[3,int] = [1,2,3]
    check len(arr)==3
    check arr[1]==2
    arr[0]=99; check arr[0]==99

  test "seq dynamic + filter/map":
    var seq1 = @[10,20,30]
    seq1.add(40); check seq1== @[10,20,30,40]
    check 20 in seq1
    check seq1.filterIt(it>15)== @[20,30,40]
    check seq1.mapIt(it*2)== @[20,40,60,80]
    check sorted(@[3,1,2])== @[1,2,3]

  test "tuple + destructuring":
    let person = (name:"Ada", age:30, lang:"Nim")
    check person.name=="Ada"
    let (n,a,l)=person
    check n=="Ada" and a==30 and l=="Nim"

  test "Table + OrderedTable":
    var capitals = {"Kenya":"Nairobi","Japan":"Tokyo"}.toTable
    capitals["France"]="Paris"
    check capitals["Japan"]=="Tokyo"
    check capitals.hasKey("Kenya")
    var ordered = initOrderedTable[string,int]()
    ordered["a"]=1; ordered["b"]=2
    check ordered["b"]==2

  test "HashSet ops":
    var s1=[1,2,3].toHashSet
    s1.incl(4)
    check 3 in s1
    let s2=[3,4,5].toHashSet
    check (s1+s2).len==5
    check (s1*s2)==[3,4].toHashSet
    check (s1 - s2)==[1,2].toHashSet

  test "seq slicing + countTable":
    let nums = toSeq(1..10)
    check nums.foldl(a+b)==55
    check nums.filter(x=>x mod 2==0)== @[2,4,6,8,10]
    check nums[2..5]== @[3,4,5,6]
    var freq=initCountTable[char]()
    for ch in "hello": freq.inc(ch)
    check freq['l']==2
