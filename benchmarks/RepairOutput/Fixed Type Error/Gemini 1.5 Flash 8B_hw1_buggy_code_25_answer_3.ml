```ocaml
let distance (x1, y1) (x2, y2) = 
  sqrt (float_of_int ((y2-y1) * (y2-y1)) +. float_of_int((x2- x1) * (x2- x1)))
```
