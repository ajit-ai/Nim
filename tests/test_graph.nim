# test_graph.nim — tests for algorithms/graph/graph.nim
# Run: nim c -r tests/test_graph.nim
import std/unittest
import std/[tables, deques, sets, sequtils, algorithm, heapqueue]

type Graph = Table[int, seq[int]]
type WeightedGraph = Table[int, seq[(int,int)]]

proc bfs(g: Graph, start:int): seq[int] =
  var visited=initHashSet[int]()
  var q=initDeque[int]()
  q.addLast(start); visited.incl(start)
  while q.len>0:
    let u=q.popFirst()
    result.add(u)
    for v in g.getOrDefault(u):
      if v notin visited: visited.incl(v); q.addLast(v)

proc dfsRec(g:Graph, u:int, visited:var HashSet[int], order:var seq[int]) =
  visited.incl(u); order.add(u)
  for v in g.getOrDefault(u):
    if v notin visited: dfsRec(g,v,visited,order)
proc dfs(g:Graph, start:int): seq[int] =
  var visited=initHashSet[int](); var order: seq[int]
  dfsRec(g,start,visited,order); order

proc dijkstra(g: WeightedGraph, src:int): Table[int,int] =
  var dist=initTable[int,int]()
  for k in g.keys: dist[k]=high(int)
  for vs in g.values:
    for (v,_ ) in vs:
      if v notin dist: dist[v]=high(int)
  dist[src]=0
  var pq: HeapQueue[(int,int)]
  pq.push((0,src))
  var visited=initHashSet[int]()
  while pq.len>0:
    let (d,u)=pq.pop()
    if u in visited: continue
    visited.incl(u)
    for (v,w) in g.getOrDefault(u):
      if d+w < dist[v]: dist[v]=d+w; pq.push((dist[v], v))
  dist

proc topoSort(g: Graph): seq[int] =
  var indeg=initTable[int,int]()
  for u, neigh in g:
    if u notin indeg: indeg[u]=0
    for v in neigh: indeg[v]=indeg.getOrDefault(v,0)+1
  var q=initDeque[int]()
  for k,v in indeg:
    if v==0: q.addLast(k)
  while q.len>0:
    let u=q.popFirst()
    result.add(u)
    for v in g.getOrDefault(u):
      indeg[v]-=1
      if indeg[v]==0: q.addLast(v)

suite "algorithms/graph":
  let g: Graph = {1: @[2,3], 2: @[4], 3: @[4,5], 4: newSeq[int](), 5: newSeq[int]()}.toTable
  test "BFS order":
    let b=bfs(g,1)
    check b.len==5
    check b[0]==1
    check b.contains(4) and b.contains(5)
    # BFS layer order: 1 then 2,3 then 4,5
    check b== @[1,2,3,4,5] or b== @[1,3,2,4,5]

  test "DFS order covers all":
    let d=dfs(g,1)
    check d.len==5
    check d[0]==1
    check d.toHashSet == [1,2,3,4,5].toHashSet

  test "Dijkstra shortest path":
    let wg: WeightedGraph = {0: @[(1,4),(2,1)], 1: @[(3,1)], 2: @[(1,2),(3,5)], 3: newSeq[(int,int)]()}.toTable
    let dm=dijkstra(wg,0)
    check dm[0]==0
    check dm[1]==3  # 0->2 (1) ->1 (2) =3
    check dm[2]==1
    check dm[3]==4  # 0->2->1->3 =1+2+1=4

  test "topological sort valid":
    let dag: Graph = {5: @[2,0], 4: @[0,1], 2: @[3], 3: @[1], 0: newSeq[int](), 1: newSeq[int]()}.toTable
    let topo=topoSort(dag)
    check topo.len==6
    # verify order respects edges: 5 before 2, 4 before 0, etc.
    proc pos(n:int):int = topo.find(n)
    check pos(5) < pos(2)
    check pos(4) < pos(0)
    check pos(3) < pos(1)
