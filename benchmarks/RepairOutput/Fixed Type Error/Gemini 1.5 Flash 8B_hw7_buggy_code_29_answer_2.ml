```ocaml
let string_implode (l : char list) : string =
  List.fold_left (fun acc c -> acc ^ Char.escaped c) "" l
```
