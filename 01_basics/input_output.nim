# input_output.nim — echo, debugEcho, stdin, formatted output
# Run: nim c -r 01_basics/input_output.nim
# (for stdin demo, run interactively or pipe input)

import std/strformat, std/strutils

echo "Hello, World! (echo adds newline)"
stdout.write("stdout.write — no newline. ")
stdout.writeLine("writeLine adds newline")

# Formatted strings — fmt (interpolated) vs & (alias)
let name = "Ada"
let lang = "Nim"
let ver = 2.2
echo fmt"{name} loves {lang} v{ver:.1f}"
echo &"2 + 2 = {2+2}"

# Debugging helper (goes to stderr)
debugEcho "debugEcho -> stderr, visible even with --hints:off"

# String formatting styles
echo "formatFloat: ", formatFloat(3.14159, precision=2)
echo "toHex: ", toHex(255)

# Reading stdin (commented for CI; uncomment to test interactively)
# echo "Enter your name: "
# let userName = readLine(stdin).strip()
# echo fmt"Hello, {userName}!"

# Simulated input via string
let simulated = "42"
let num = parseInt(simulated)
echo "parsed simulated input '42' -> ", num, " *2=", num*2

# Command-line args preview (see 10_file_io)
import std/os
echo "program name: ", paramStr(0)
echo "arg count: ", paramCount()
if paramCount() > 0:
  echo "first arg: ", paramStr(1)
