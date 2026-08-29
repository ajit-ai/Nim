# Nim by Example — Complete Feature & Algorithm Demos

> Learn Nim (v2.2.4) through runnable examples: every language feature + classic algorithms.

This repo is structured as **11 language chapters** + **algorithms** + **real-world examples**. Each `.nim` file is self-contained and runnable with `nim c -r <file>`.

Original repo: https://github.com/ajit-ai/Nim

## Quick Start

```bash
# Install Nim via choosenim: https://nim-lang.org/install.html
nim --version  # 2.2.4

# Run any demo
nim c -r 01_basics/hello.nim
nim c -r 02_control_flow/loops.nim
nim c -r algorithms/sorting/sorting.nim
```

## Repository Structure

```
basic/                          # original hello / Values demos (kept)
01_basics/                      # hello, variables, datatypes, operators, I/O
02_control_flow/                # if/when/case, loops, iterators, blocks, defer
03_procedures/                  # procs, overloading, recursion, closures, HOF
04_collections/                 # array, seq, string, table, set, tuple
05_types/                       # objects, enums, variants, refs, distinct
06_oop/                         # inheritance, methods, concepts (interfaces)
07_generics_metaprogramming/    # generics, templates, macros, concepts, static
08_error_handling/              # exceptions, defer, Option/Result idioms
09_modules/                     # modules, imports, nimble packages
10_file_io/                     # files, JSON, OS, parseopt (CLI)
11_concurrency/                 # threads, async/await, channels
algorithms/
  sorting/                      # bubble, insertion, quick, merge, heap
  searching/                    # linear, binary, BFS/DFS demo
  graph/                        # BFS, DFS, Dijkstra, topological sort
  dynamic_programming/          # fibonacci, knapsack, LCS, coin change
  math/                         # gcd, sieve, factorial, prime, fast pow
  strings/                      # palindrome, anagram, KMP, reverse
examples/                       # CLI todo app, HTTP server, FFI stub
```

## How to Use Each Demo

Every file follows:

```nim
# Title: What it shows
# Run: nim c -r path/to/file.nim
# Concepts: bullet list
```

Output is printed via `echo`. Read the comments for edge cases.

## Index of Demos

### Basics & Control Flow
| File | Concepts |
|------|----------|
| `01_basics/variables.nim` | `var`, `let`, `const`, type inference, `block` scope |
| `01_basics/datatypes.nim` | int, float, char, bool, string, conversions, sizeof |
| `01_basics/operators.nim` | arithmetic, bitwise, string ops |
| `02_control_flow/if_when_case.nim` | `if`/`elif`/`else`, `when` (compile-time), `case` |
| `02_control_flow/loops.nim` | `for`, `while`, `break`/`continue`, nested |
| `02_control_flow/iterators.nim` | custom iterators, `closure` iterators |

### Procedures & Collections
| File | Concepts |
|------|----------|
| `03_procedures/procs.nim` | `proc`/`func`, default args, overloading, `var` params, recursion |
| `03_procedures/closures_hof.nim` | closures, `=>`, `map`/`filter`/`foldl`, mutual recursion |
| `04_collections/collections.nim` | `array`, `seq`, `Table`/`OrderedTable`, `HashSet`, `tuple`, `sequtils` |
| `05_types/objects.nim` | `object`, `ref object`, `enum`, `distinct`, `variant`, `Option` |
| `06_oop/oop.nim` | `ref object of RootObj`, `method` dispatch, `of`, `concept Drawable` |
| `07_generics_metaprogramming/metaprogramming.nim` | generics `Stack[T]`, `concept Addable`, `static`, `template`, `macro debug` |
| `08_error_handling/exceptions.nim` | `try`/`except`/`finally`, `defer`, `Option`/`Result`, `doAssert` |
| `09_modules/modules_demo.nim` | `import`/`from`/`as`, `when defined(debug)`, `math_utils` local module |
| `10_file_io/file_io.nim` | `writeFile`/`lines`, `json`, `parseopt`, `os`/`getTempDir` |
| `11_concurrency/concurrency.nim` | `asyncdispatch`/`await`/`all`, `Channel`, `threadpool`/`Thread` |

### Algorithms (complexity in comments)
| File | What it shows |
|------|---------------|
| `algorithms/sorting/sorting.nim` | bubble O(n²), insertion O(n²), selection O(n²), quick O(n log n), merge O(n log n), `algorithm.sort` |
| `algorithms/searching/searching.nim` | linear O(n), binary O(log n), lowerBound, KMP naive, jump search |
| `algorithms/graph/graph.nim` | BFS/DFS, Dijkstra O((V+E) log V), topological sort (Kahn) |
| `algorithms/dynamic_programming/dp.nim` | fib memo/iter, knapsack O(nW), LCS, coin change, edit distance |
| `algorithms/math/math.nim` | gcd/lcm, sieve, `isPrime`, `factorize`, `modPow`, `nCr` |
| `algorithms/strings/strings.nim` | palindrome, `isAnagram`, KMP O(n+m), longestPal, `wordCount`, RLE |

### Examples
| File | What it shows |
|------|---------------|
| `examples/cli_todo.nim` | `parseopt` + JSON persistence, `isMainModule`, CRUD CLI |
| `examples/http_server.nim` | `asynchttpserver` routes `/`, `/json`, `/hello?name=`, `async` handler |

## Testing — One Suite per Demo

Every demo has a matching `tests/test_*.nim` using `std/unittest` (`suite`/`test`/`check`).

| Test file | Covers Demo |
|-----------|-------------|
| `tests/test_variables.nim` | `01_basics/variables.nim:1` |
| `tests/test_datatypes.nim` | `01_basics/datatypes.nim:1` |
| `tests/test_operators.nim` | `01_basics/operators.nim:1` |
| `tests/test_input_output.nim` | `01_basics/input_output.nim:1` |
| `tests/test_control_flow.nim` | `02_control_flow/if_when_case.nim:1`, `loops.nim:1`, `iterators.nim:1` |
| `tests/test_hello_values.nim` | `basic/hello.nim:1`, `basic/Values.nim:1` |
| `tests/test_procs.nim` | `03_procedures/procs.nim:1`, `closures_hof.nim:1` |
| `tests/test_collections.nim` | `04_collections/collections.nim:1` |
| `tests/test_types.nim` | `05_types/objects.nim:1` |
| `tests/test_oop.nim` | `06_oop/oop.nim:1` |
| `tests/test_metaprogramming.nim` | `07_generics_metaprogramming/metaprogramming.nim:1` |
| `tests/test_exceptions.nim` | `08_error_handling/exceptions.nim:1` |
| `tests/test_modules.nim` | `09_modules/math_utils.nim:1`, `modules_demo.nim:1` |
| `tests/test_file_io.nim` | `10_file_io/file_io.nim:1` |
| `tests/test_concurrency.nim` | `11_concurrency/concurrency.nim:1` |
| `tests/test_sorting.nim` | `algorithms/sorting/sorting.nim:1` |
| `tests/test_searching.nim` | `algorithms/searching/searching.nim:1` |
| `tests/test_graph.nim` | `algorithms/graph/graph.nim:1` |
| `tests/test_dp.nim` | `algorithms/dynamic_programming/dp.nim:1` |
| `tests/test_math.nim` | `algorithms/math/math.nim:1` |
| `tests/test_strings.nim` | `algorithms/strings/strings.nim:1` |
| `tests/test_examples.nim` | `examples/cli_todo.nim:1`, `http_server.nim:1` |
| `tests/all_tests.nim` | aggregator (22 suites, 150+ tests) |

Run:

```bash
# Single suite (verbose [OK] per test)
nim c -r tests/test_variables.nim
nim c -r tests/test_datatypes.nim
nim c -r tests/test_control_flow.nim

# All suites via Nimble (recommended)
nimble test

# Aggregator
nim c -r tests/all_tests.nim
```

All 22 suites pass with Nim 2.2.4 (`[OK]` for ~150 tests). When adding a new demo, add a matching `tests/test_your_demo.nim` and register it in `Nim.nimble:11` `task test`.

## Contributing
Add a new demo as `XX_topic/your_demo.nim` with header comment and ensure `nim c -r` and `nimble test` pass.

## License
MIT
