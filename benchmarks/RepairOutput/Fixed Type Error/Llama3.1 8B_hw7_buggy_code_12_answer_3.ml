```haskell
let string_implode (l : string list) : string =
  String.concat "" (List.map (fun c -> Char.escaped c) l)
```