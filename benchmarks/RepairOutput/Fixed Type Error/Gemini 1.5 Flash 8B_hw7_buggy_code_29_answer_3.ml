```ocaml
let string_implode (l : char list) : string =
  let l= List.map (Char.escaped) l in
  List.fold_left (fun acc c -> acc ^ c) "" l
```
