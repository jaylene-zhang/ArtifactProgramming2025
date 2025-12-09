```ocaml
let string_implode (l : char list) : string =
  String.concat "" (List.map Char.escaped l)
```
