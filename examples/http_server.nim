# http_server.nim — tiny HTTP server using std/httpclient & asynchttpserver
# Run: nim c -r examples/http_server.nim
# Then: curl http://localhost:8080/  or open browser
import std/[asynchttpserver, asyncdispatch, json, strformat, strutils]

proc handler(req: Request) {.async.} =
  let path = req.url.path
  case path
  of "/":
    let body = """<h1>Nim HTTP Demo</h1><p>Try <a href="/json">/json</a> or <a href="/hello?name=Ada">/hello?name=Ada</a></p>"""
    await req.respond(Http200, body, newHttpHeaders([("Content-Type","text/html")]))
  of "/json":
    let j = %* {"lang":"Nim","version": NimVersion, "message":"Hello from Nim server"}
    await req.respond(Http200, $j, newHttpHeaders([("Content-Type","application/json")]))
  of "/hello":
    # query param parse naive
    let q = req.url.query
    var name = "world"
    for pair in q.split('&'):
      let kv = pair.split('=',1)
      if kv.len==2 and kv[0]=="name": name = kv[1]
    await req.respond(Http200, &"Hello, {name}!", newHttpHeaders([("Content-Type","text/plain")]))
  else:
    await req.respond(Http404, "Not found: " & path)

when isMainModule:
  var server = newAsyncHttpServer()
  echo "Serving at http://localhost:8080  (Ctrl+C to stop)"
  # For demo CI, only listen if not in test env
  when not defined(testing):
    waitFor server.serve(Port(8080), handler)
