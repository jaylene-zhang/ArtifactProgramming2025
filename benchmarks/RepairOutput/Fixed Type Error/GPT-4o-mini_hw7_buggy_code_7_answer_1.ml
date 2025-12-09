```ocaml
let string_implode (l : char list) : string =
  List.fold_left (fun acc x -> acc ^ (Char.escaped x)) "" l
```