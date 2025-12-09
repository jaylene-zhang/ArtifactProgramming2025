```ocaml
let to_int (n : int church) : int = 
  let f x = x + 1 in
  let base = 0 in
  n base f
```