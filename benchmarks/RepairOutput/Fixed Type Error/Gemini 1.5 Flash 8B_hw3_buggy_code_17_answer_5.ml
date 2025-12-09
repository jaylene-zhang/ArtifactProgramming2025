```ocaml
let to_int (n : int church) : int =
  let rec helper (s, z) =
    match n with
    | Succ s' -> 1 + helper (s', z)
    | Zero -> 0
  in
  helper n
```
