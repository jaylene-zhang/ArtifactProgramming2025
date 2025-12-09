```haskell
let to_int (n : int church) : int = 
  let rec helper (s, z) = match n with
    | (s, z) -> s
  in
  helper n
```