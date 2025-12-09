```OCaml
let to_int (n : int church) : int =
  let rec helper (s, z) = match n with
    | S s' -> 1 + helper (s', z)
    | Z -> 0
  in
  helper n
```
