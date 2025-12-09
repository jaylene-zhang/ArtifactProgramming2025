```haskell
let rec take n s acc =
  match n with
  | 0 -> acc
  | num -> take (num - 1) (s.tail ()) (@) (acc :: [s.head])
```