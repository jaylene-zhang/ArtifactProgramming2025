```ocaml
let to_int (n : int church) : int = 
  let rec helper (a : 'b church) : int = 
    match a with
    | zero -> 0
    | one -> 1
    | s z -> 1 + helper (s z)
  in
  helper n
```