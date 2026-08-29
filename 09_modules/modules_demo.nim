# modules_demo.nim — modules, imports, exports, include
# Run: nim c -r 09_modules/modules_demo.nim
import std/[strformat, sequtils, tables]
import ./math_utils  # local module

echo "math_utils.square(5) = ", square(5)
echo "math_utils.cube(3) = ", cube(3)
echo "PI = ", PI

# Import alias
import std/strutils as su
echo "alias su.toUpper: ", su.toUpperAscii("nim")

# Selective import
from std/math import pow, sqrt
echo "pow(2,10) = ", pow(2.0, 10.0)
echo "sqrt(16) = ", sqrt(16.0)

# Export demo: math_utils exports via `*`
# Include vs import: include inlines file content (rarely used)
# Nimble package layout: <package>.nimble defines srcDir, requires

# Module paths: relative ./, absolute std/, third-party via nimble
# Check nimble packages: `nimble install jsony`

# Conditional import
when defined(debug):
  echo "debug build"
else:
  echo "release build (use -d:debug)"

# Inspect module: `import std/os` deferred to show works
import std/os
echo "current dir: ", getCurrentDir()
echo "param count: ", paramCount()
