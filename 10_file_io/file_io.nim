# file_io.nim — files, JSON, OS, parseopt (CLI)
# Run: nim c -r 10_file_io/file_io.nim
import std/[os, strformat, json, parseopt, strutils, sequtils]

# ---- Write & Read file ----
let tmpFile = getTempDir() / "nim_demo_test.txt"
writeFile(tmpFile, "Hello Nim\nLine 2\n")
echo &"wrote to {tmpFile}"
echo "readFile: ", readFile(tmpFile).strip()

# Append
let f = open(tmpFile, fmAppend)
f.writeLine("Appended line")
f.close()
echo "after append lines: ", readFile(tmpFile).splitLines().len

# Iterate lines
echo "lines:"
for line in lines(tmpFile):
  echo "  ", line

# ---- File existence, remove ----
echo "exists? ", fileExists(tmpFile)
echo "file size: ", getFileSize(tmpFile), " bytes"
removeFile(tmpFile)
echo "after remove exists? ", fileExists(tmpFile)

# ---- Directory ops ----
let tmpDir = getTempDir() / "nim_demo_dir"
createDir(tmpDir)
echo "created dir: ", tmpDir, " exists? ", dirExists(tmpDir)
removeDir(tmpDir)
echo "after remove exists? ", dirExists(tmpDir)

# ---- Path helpers ----
echo "joinPath: ", joinPath("a", "b", "c.txt")
echo "splitPath: ", splitPath("/foo/bar/baz.nim")
echo "expandFilename (nim): ", expandFilename("10_file_io/file_io.nim")

# ---- JSON ----
let j = %* {"name": "Nim", "version": 2.2, "features": ["fast", "expressive"]}
echo "json: ", $j
echo "json pretty:\n", j.pretty()
echo "  j[\"name\"] = ", j["name"].getStr()

# Parse JSON string
let parsed = parseJson("""{"city":"Nairobi","pop":4397073}""")
echo "parsed city: ", parsed["city"].getStr(), " pop=", parsed["pop"].getInt()

# ---- Command line parsing (parseopt) ----
# Run: nim c -r 10_file_io/file_io.nim -- --name Ada --verbose
var p = initOptParser(commandLineParams())
var name = "world"
var verbose = false
for kind, key, val in p.getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "name", "n": name = val
    of "verbose", "v": verbose = true
    else: discard
  of cmdArgument: discard
  of cmdEnd: break
echo &"parseopt name={name} verbose={verbose}"

# ---- Env vars ----
putEnv("NIM_DEMO", "hello")
echo "getEnv NIM_DEMO: ", getEnv("NIM_DEMO")
