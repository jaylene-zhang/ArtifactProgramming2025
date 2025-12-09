```ocaml
let to_int (n : int church) : int =
  let rec helper (s : int -> (int -> int) -> int) (z : int -> (int -> int) -> int) =
    match n with
    | S s' z' -> 1 + helper s' z'
    | Z -> 0
  in
  helper (fun f x -> f x) (fun f x -> x)
```
