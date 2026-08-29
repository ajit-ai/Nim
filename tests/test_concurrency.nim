# test_concurrency.nim — tests for 11_concurrency/concurrency.nim
# Run: nim c -r tests/test_concurrency.nim
import std/unittest
import std/[asyncdispatch, strformat, sequtils, threadpool]

suite "11_concurrency async + channels":
  test "async fetchData + all":
    proc fetchData(id:int): Future[string] {.async.} =
      await sleepAsync(10)
      return "data-" & $id
    proc run(): Future[seq[string]] {.async.} =
      let a=await fetchData(1)
      check a=="data-1"
      let futs = @[fetchData(2), fetchData(3)]
      result=await all(futs)
    let res=waitFor run()
    check res== @["data-2","data-3"]

  test "channels send/recv":
    # Channel is built into system (threads:on)
    var ch: Channel[int]
    ch.open()
    ch.send(10); ch.send(20)
    check ch.recv()==10
    check ch.recv()==20
    ch.close()

  test "threadpool spawn + sync":
    proc heavy(n:int):int = n*n
    let f1=spawn heavy(5)
    let f2=spawn heavy(7)
    check ^f1==25
    check ^f2==49
    sync()

  test "seq async mapping":
    proc asyncDouble(x:int): Future[int] {.async.} =
      await sleepAsync(5)
      return x*2
    proc runAll(): Future[seq[int]] {.async.} =
      var futs: seq[Future[int]]
      for i in 1..3: futs.add(asyncDouble(i))
      result=await all(futs)
    check waitFor(runAll())== @[2,4,6]
