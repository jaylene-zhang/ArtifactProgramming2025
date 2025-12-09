```haskell
let to_int (n : 'b church) : int = 
  let rec helper (a : 'b) : int = match a with
    | (s, z) -> 0
  in
  helper n
```