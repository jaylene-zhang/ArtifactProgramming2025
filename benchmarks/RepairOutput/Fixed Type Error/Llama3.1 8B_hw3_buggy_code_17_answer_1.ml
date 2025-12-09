```haskell
let to_int (n : int church) : int = 
  let rec helper (s, z) = match s with
    | 0 -> 0
    | n -> (fun x -> 1 + x) z (helper (n-1, z))
  in
  helper n
```