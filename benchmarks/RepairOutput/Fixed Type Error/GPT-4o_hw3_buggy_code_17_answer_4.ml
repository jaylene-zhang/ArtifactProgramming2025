```ocaml
let to_int (n : int church) : int = 
  let rec helper f z = f (fun x -> x + 1) z in
  helper n 0
```