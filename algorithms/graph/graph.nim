# graph.nim — BFS, DFS, Dijkstra, topological sort
# Run: nim c -r algorithms/graph/graph.nim
import std/[tables, deques, sequtils, strformat, algorithm, heapqueue, sets]

type Graph = Table[int, seq[int]]
type WeightedGraph = Table[int, seq[(int,int)]] # node -> (neighbor, weight)

proc bfs(g: Graph, start: int): seq[int] =
  var visited = initHashSet[int]()
  var q = initDeque[int]()
  q.addLast(start); visited.incl(start)
  while q.len > 0:
    let u = q.popFirst()
    result.add(u)
    for v in g.getOrDefault(u):
      if v notin visited:
        visited.incl(v); q.addLast(v)

proc dfsRec(g: Graph, u: int, visited: var HashSet[int], order: var seq[int]) =
  visited.incl(u); order.add(u)
  for v in g.getOrDefault(u):
    if v notin visited: dfsRec(g, v, visited, order)

proc dfs(g: Graph, start: int): seq[int] =
  var visited = initHashSet[int]()
  var order: seq[int]
  dfsRec(g, start, visited, order)
  order

# Unweighted graph demo
let g: Graph = {
  1: @[2,3], 2: @[4], 3: @[4,5], 4: @[], 5: @[]
}.toTable

echo "graph: ", g
echo "BFS from 1: ", bfs(g, 1)  # 1 2 3 4 5
echo "DFS from 1: ", dfs(g, 1)

# Weighted Dijkstra O((V+E) log V)
proc dijkstra(g: WeightedGraph, src: int): Table[int,int] =
  var dist = initTable[int,int]()
  for k in g.keys: dist[k]=high(int)
  for vs in g.values:
    for (v,_) in vs:
      if v notin dist: dist[v]=high(int)
  dist[src]=0
  var pq: HeapQueue[(int,int)]  # (dist, node)
  pq.push((0,src))
  var visited = initHashSet[int]()
  while pq.len > 0:
    let (d,u) = pq.pop()
    if u in visited: continue
    visited.incl(u)
    for (v,w) in g.getOrDefault(u):
      if d + w < dist[v]:
        dist[v] = d + w
        pq.push((dist[v], v))
  dist

let wg: WeightedGraph = {
  0: @[(1,4),(2,1)], 1: @[(3,1)], 2: @[(1,2),(3,5)], 3: newSeq[(int,int)]()
}.toTable

echo "weighted graph: ", wg
let dists = dijkstra(wg, 0)
for k in dists.keys.toSeq.sorted:
  echo &"  dist 0->{k} = {dists[k]}"

# Topological sort (Kahn)
proc topoSort(g: Graph): seq[int] =
  var indeg = initTable[int,int]()
  for u, neigh in g:
    if u notin indeg: indeg[u]=0
    for v in neigh:
      indeg[v] = indeg.getOrDefault(v,0)+1
  var q = initDeque[int]()
  for k,v in indeg:
    if v==0: q.addLast(k)
  while q.len>0:
    let u = q.popFirst()
    result.add(u)
    for v in g.getOrDefault(u):
      indeg[v]-=1
      if indeg[v]==0: q.addLast(v)

let dag: Graph = {5: @[2,0], 4: @[0,1], 2: @[3], 3: @[1], 0: newSeq[int](), 1: newSeq[int]()}.toTable
echo "DAG topoSort: ", topoSort(dag)
