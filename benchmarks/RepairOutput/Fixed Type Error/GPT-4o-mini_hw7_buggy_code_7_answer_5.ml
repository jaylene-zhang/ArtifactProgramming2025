```ocaml
let string_implode (l : char list) : string =
  String.concat "" (List.map (String.make 1) l)
```