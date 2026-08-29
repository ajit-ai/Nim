# cli_todo.nim — minimal CLI todo app (parseopt + JSON persistence)
# Run: nim c -r examples/cli_todo.nim -- --help
#      nim c -r examples/cli_todo.nim -- add "Buy milk"
#      nim c -r examples/cli_todo.nim -- list
import std/[parseopt, strformat, strutils, json, os, sequtils]

const dbFile = "todo.json"

proc loadTodos(): seq[string] =
  if not fileExists(dbFile): return @[]
  try: parseJson(readFile(dbFile)).to(seq[string]) except: @[]

proc saveTodos(todos: seq[string]) =
  writeFile(dbFile, (%todos).pretty())

proc usage() =
  echo """Usage:
  cli_todo --add "task" | -a "task"   Add task
  cli_todo --list | -l                List tasks
  cli_todo --clear                    Clear all
  cli_todo --help | -h                Help"""

when isMainModule:
  var todos = loadTodos()
  var p = initOptParser(commandLineParams())
  var didSomething = false
  for kind, key, val in p.getopt():
    case kind
    of cmdLongOption, cmdShortOption:
      case key
      of "add", "a":
        # val may be next arg if --add separate
        var task = val
        if task == "" and p.remainingArgs.len > 0:
          task = p.remainingArgs[0]
        if task != "":
          todos.add(task)
          saveTodos(todos)
          echo &"Added: {task} (total {todos.len})"
          didSomething=true
      of "list", "l":
        if todos.len==0: echo "No todos"
        else:
          for i, t in todos: echo &"{i+1}. {t}"
        didSomething=true
      of "clear":
        todos = @[]; saveTodos(todos); echo "Cleared"; didSomething=true
      of "help", "h": usage(); didSomething=true
      else: echo &"Unknown --{key}"; usage(); didSomething=true
    of cmdArgument:
      # bare arg treated as add
      todos.add(key); saveTodos(todos); echo &"Added: {key}"; didSomething=true
    of cmdEnd: break
  if not didSomething:
    usage()
    if todos.len>0:
      echo "\nCurrent todos:"
      for i,t in todos: echo &"  {i+1}. {t}"
