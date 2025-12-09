```ocaml
let to_int (n : int church) : int = 
  let rec helper (s, z) = match s with
    | (s', z') -> helper (s' (z (s z')), z)
    | z -> 0
  in
  helper (n (fun x -> x + 1) fun x -> x)
```