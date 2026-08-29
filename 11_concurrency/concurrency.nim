# concurrency.nim — async/await, threads, channels (Nim 2.x)
# Run: nim c -r 11_concurrency/concurrency.nim
import std/[asyncdispatch, strformat, os, sequtils]

# ---- async/await (asyncdispatch) ----
proc fetchData(id: int): Future[string] {.async.} =
  await sleepAsync(100)  # ms
  result = &"data-{id}"

proc asyncDemo() {.async.} =
  echo "asyncDemo start"
  let a = await fetchData(1)
  let b = await fetchData(2)
  echo &"  fetched: {a}, {b}"
  # Parallel fetch
  let futures = @[fetchData(3), fetchData(4), fetchData(5)]
  let results = await all(futures)
  echo &"  parallel: {results}"

waitFor asyncDemo()

# ---- Channels (thread communication) ----
# Channels are built into `system` when --threads:on (default). No import needed.
var ch: Channel[int]
ch.open()

proc producer() =
  for i in 1..5:
    ch.send(i * 10)
    echo &"  producer sent {i*10}"
  ch.send(-1)  # sentinel

proc consumer() =
  while true:
    let v = ch.recv()
    if v == -1: break
    echo &"  consumer got {v}"

producer()
consumer()
ch.close()

# ---- Threads (if compiled with --threads:on, which is default) ----
import std/threadpool  # deprecated but simple; for new code use `thread` pragma

proc heavy(n: int): int =
  sleep(50)
  n * n

# Use spawn (threadpool)
let f1 = spawn heavy(5)
let f2 = spawn heavy(7)
echo &"spawn heavy 5 -> {^f1}, 7 -> {^f2}"  # ^ dereferences FlowVar
sync()  # wait for pool

# Modern thread with `{.thread.}` pragma
var thr: Thread[int]
proc threadProc(x: int) {.thread.} =
  echo &"  thread running with {x}"

createThread(thr, threadProc, 42)
joinThread(thr)

echo "concurrency demo done"
