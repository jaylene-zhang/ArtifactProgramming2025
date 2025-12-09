```haskell
let rec sum (l : 'b church list) : 'b church =
  match l with
  | [] -> zero
  | h :: t -> add h (sum t)
```