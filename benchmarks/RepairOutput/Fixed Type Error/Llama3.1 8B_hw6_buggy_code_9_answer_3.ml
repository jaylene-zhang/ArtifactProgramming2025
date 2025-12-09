```haskell
let rec traverse (f : 'a -> 'b option) (l : 'a list) : ('b option) list option =
  match l with
  | [] -> Some []
  | x :: xs -> (match f x with | None -> None | Some y -> (Some y) :: (traverse f xs))
```