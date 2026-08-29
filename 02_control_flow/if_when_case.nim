# if_when_case.nim — branching
# Run: nim c -r 02_control_flow/if_when_case.nim

# ---- if / elif / else (also expression) ----
let score = 85
let grade = if score >= 90: "A"
            elif score >= 80: "B"
            elif score >= 70: "C"
            else: "F"
echo "score ", score, " -> grade ", grade

# ---- when — compile-time branch ----
when defined(release):
  echo "when: release build"
else:
  echo "when: debug build (nim c without -d:release)"

const nimVersionCheck = NimVersion
when NimVersion >= "2.0.0":
  echo "Nim >= 2.0 confirmed: ", NimVersion

# ---- case (switch) ----
let lang = "Nim"
case lang
of "Nim":
  echo "fast + expressive"
of "Python", "Ruby":
  echo "dynamic"
of "C", "C++":
  echo "low-level"
else:
  echo "unknown lang"

# case with ranges and multiple values
let n = 7
case n
of 1..3: echo n, " is small"
of 4..6: echo n, " is medium"
of 7..9: echo n, " is large"
else:    echo n, " is out of range"

# ---- if as expression in let ----
let status = if n mod 2 == 0: "even" else: "odd"
echo n, " is ", status

# ---- truthiness — Nim requires explicit bool ----
var maybe = 0
# if maybe:  # compile error! int cannot be used as bool
if maybe != 0:
  echo "maybe is truthy"
else:
  echo "maybe is falsy (0)"
