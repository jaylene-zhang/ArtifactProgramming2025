```ocaml
let string_implode (l : char list) : string =
  let l = List.map (fun c -> Char.escaped c) l in
  String.concat "" l
```