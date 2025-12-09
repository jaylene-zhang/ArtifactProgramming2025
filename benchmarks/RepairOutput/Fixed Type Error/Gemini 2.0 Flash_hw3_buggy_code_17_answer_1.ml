```ocaml
let to_int (n : int church) : int =
  let rec helper n = n (fun x -> x + 1) 0
  in
  helper n
```