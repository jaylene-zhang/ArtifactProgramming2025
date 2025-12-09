```OCaml
let to_int (n : int church) : int =
  let rec helper (s, z) = match n with
    | S n' -> 1 + helper n'
    | Z -> 0
  in
  helper n
```
