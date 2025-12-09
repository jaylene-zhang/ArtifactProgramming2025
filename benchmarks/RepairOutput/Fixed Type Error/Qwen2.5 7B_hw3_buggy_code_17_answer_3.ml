```ocaml
let to_int (n : int church) : int = 
  let rec helper a = match a with
    | s, z -> 0 (* This should be a recursive call to `s` with the incremented value *)
  in
  helper (n, (fun x -> x + 1), 0)
```