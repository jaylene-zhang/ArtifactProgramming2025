```haskell
let rec sum = function
  | [] -> one
  | h::t -> add h (sum t)
```