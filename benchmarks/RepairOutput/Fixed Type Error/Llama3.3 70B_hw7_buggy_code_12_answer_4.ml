```ocaml
let string_implode (l : char list) : string =
  let c = List.map (String.make 1) l in
  List.fold_left (String.concat) "" c
```