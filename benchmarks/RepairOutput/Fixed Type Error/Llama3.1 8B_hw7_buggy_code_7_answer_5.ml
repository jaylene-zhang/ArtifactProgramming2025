```ocaml
let string_implode (l : char list) : string =
  String.concat "" (List.map (fun x -> Char.escaped x) l)
```