```ocaml
let to_int (n : int church) : int = 
  let rec helper s z = n s z in
  helper (fun x -> x + 1) 0
```