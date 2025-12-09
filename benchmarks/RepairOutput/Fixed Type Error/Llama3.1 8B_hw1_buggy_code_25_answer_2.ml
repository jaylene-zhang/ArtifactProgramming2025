`sqrt` expects a `float` argument, but you're providing an `int` argument due to the `*` operator implicitly performing integer multiplication. Ocaml requires an explicit `(float_of_int)` operator wrapper for such cases.

```ocaml
let distance (x1, y1) (x2, y2) = 
  sqrt ((float_of_int (y2-y1) *. (float_of_int (y2-y1)) +. (float_of_int (x2- x1) *. float_of_int(x2- x1)))
```