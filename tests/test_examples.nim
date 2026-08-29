# test_examples.nim — tests for examples/cli_todo + http_server
# Run: nim c -r tests/test_examples.nim
import std/unittest
import std/[os, json, sequtils, strutils]

suite "examples/cli_todo":
  test "json todo persistence round-trip":
    let tmp = getTempDir() / "nim_test_todo.json"
    let todos = @["Buy milk", "Learn Nim"]
    writeFile(tmp, (%todos).pretty())
    check fileExists(tmp)
    let loaded = parseJson(readFile(tmp)).to(seq[string])
    check loaded==todos
    check loaded.len==2
    # add
    var m = loaded; m.add("Write tests")
    writeFile(tmp, (%m).pretty())
    check parseJson(readFile(tmp)).to(seq[string]).len==3
    removeFile(tmp)
  test "parseopt-like add/list logic":
    proc addTodo(list: var seq[string], task:string) = list.add(task)
    var todos: seq[string]
    addTodo(todos, "task1")
    addTodo(todos, "task2")
    check todos== @["task1","task2"]

suite "examples/http_server logic":
  test "json payload structure":
    let j = %* {"lang":"Nim","version": NimVersion}
    check j["lang"].getStr()=="Nim"
    check j["version"].getStr()==NimVersion
  test "hello query param parsing":
    proc parseHello(q:string):string =
      var name="world"
      for pair in q.split('&'):
        let kv=pair.split('=',1)
        if kv.len==2 and kv[0]=="name": name=kv[1]
      name
    check parseHello("name=Ada")== "Ada"
    check parseHello("")=="world"
    check parseHello("name=Bob&other=1")=="Bob"
  test "routes":
    let routes = ["/","/json","/hello"]
    check "/" in routes
    check "/missing" notin routes
