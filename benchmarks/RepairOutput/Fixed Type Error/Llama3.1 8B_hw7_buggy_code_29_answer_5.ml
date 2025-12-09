```haskell
let string_implode (l : char list) : string =
  List.map (Char.escaped) l |> List.fold_right (fun x acc -> acc ^ x)
```