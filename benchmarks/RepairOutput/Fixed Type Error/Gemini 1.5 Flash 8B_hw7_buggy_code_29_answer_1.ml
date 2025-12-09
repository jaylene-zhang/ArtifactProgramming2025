```ocaml
let string_implode (l : char list) : string =
  List.fold_left (^) "" (List.map Char.escaped l)
```
