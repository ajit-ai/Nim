# test_file_io.nim — tests for 10_file_io/file_io.nim
# Run: nim c -r tests/test_file_io.nim
import std/unittest
import std/[os, json, strutils, sequtils, parseopt]

suite "10_file_io":
  test "writeFile / readFile / append / lines":
    let tmp = getTempDir() / "nim_test_file_io.txt"
    writeFile(tmp, "Hello Nim\nLine 2\n")
    check readFile(tmp).contains("Hello Nim")
    let f=open(tmp, fmAppend); f.writeLine("Appended"); f.close()
    check readFile(tmp).contains("Appended")
    var count=0
    for line in lines(tmp): inc count
    check count==3
    removeFile(tmp)
    check not fileExists(tmp)

  test "dirs + paths":
    let d = getTempDir() / "nim_test_dir"
    createDir(d)
    check dirExists(d)
    removeDir(d)
    check not dirExists(d)
    check joinPath("a","b","c.txt") == "a" / "b" / "c.txt"
    check splitPath("/foo/bar/baz.nim").tail=="baz.nim"

  test "json %* and parseJson":
    let j = %* {"name":"Nim","version":2.2}
    check j["name"].getStr()=="Nim"
    check abs(j["version"].getFloat() - 2.2) < 1e-9
    let parsed=parseJson("""{"city":"Nairobi","pop":4397073}""")
    check parsed["city"].getStr()=="Nairobi"
    check parsed["pop"].getInt()==4397073
    let pretty = j.pretty()
    check pretty.contains("Nim")

  test "parseopt + env":
    var p=initOptParser("--name=Ada --verbose")
    var name="world"; var verbose=false
    for kind,key,val in p.getopt():
      if key=="name": name=val
      if key=="verbose": verbose=true
    check name=="Ada"
    check verbose==true
    putEnv("NIM_DEMO","hello")
    check getEnv("NIM_DEMO")=="hello"
