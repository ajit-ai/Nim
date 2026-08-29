# datatypes.nim — Nim's core datatypes
# Run: nim c -r 01_basics/datatypes.nim
# Concepts: ints, floats, bool, char, string, conversions, sizeof

# ---- Integers ----
var i8: int8 = 127
var i16: int16 = 32000
var i32: int32 = 2_000_000_000
var i64: int64 = 9_000_000_000'i64
var u: uint = 42'u
echo "ints: ", i8, " ", i16, " ", i32, " ", i64, " ", u
echo "int size on this arch: ", sizeof(int), " bytes"

# ---- Floats ----
var f32: float32 = 3.14'f32
var f64: float = 2.71828    # float is alias for float64
echo "floats: ", f32, " ", f64

# ---- Bool & Char ----
var t = true
var f = false
var ch: char = 'Z'
echo "bool: ", t, " and ", f, " not true=", not t
echo "char: ", ch, " ord=", ord(ch), " chr=", chr(65)

# ---- String ----
var s = "nimble"
echo "string: ", s, " len=", len(s), " upper? ", s & "!"
echo "s[0]=", s[0], " s[^1]=", s[^1]  # ^1 = last element

# Raw string & multi-line
let raw = r"C:\path\to\file.nim"
let multi = """line1
line2
line3"""
echo raw
echo multi

# ---- Conversions ----
let intVal = 42
let floatVal = float(intVal)  # int -> float
let strVal = $intVal          # int -> string via $
let parsed = parseInt("123")  # string -> int
import std/strutils
echo "conversions: ", floatVal, " ", strVal, " ", parsed
echo "parseFloat: ", parseFloat("3.14")

# ---- Type checking ----
echo "is int? ", intVal is int
echo "is string? ", strVal is string

# ---- Distinct / type alias demo (preview) ----
type Meters = distinct float
let m: Meters = 5.0.Meters
echo "distinct Meters: ", m.float, " meters"
