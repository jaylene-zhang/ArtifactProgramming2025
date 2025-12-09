```ocaml
let to_int (n : int church) : int = 
  let rec helper (a : int church) : int = 
    a (fun x -> x + 1) 0
  in
  helper n
```