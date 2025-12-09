```ocaml
let to_int (n : int church) : int = 
  let rec helper (a : int * int -> int) : int = 
    match a with
    | (s, z) -> z
  in
  helper n
```