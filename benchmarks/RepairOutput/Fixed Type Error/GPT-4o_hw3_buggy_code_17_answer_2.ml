```ocaml
let to_int (n : int church) : int = 
  n 0 (fun x -> x + 1)
```