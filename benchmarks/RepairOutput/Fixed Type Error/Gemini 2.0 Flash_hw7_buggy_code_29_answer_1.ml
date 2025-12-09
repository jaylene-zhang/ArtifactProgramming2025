```ocaml
let string_implode (l : char list) : string =
  let l= List.map (Char.escaped) l in
  List.fold_left (^) "" (l)
```