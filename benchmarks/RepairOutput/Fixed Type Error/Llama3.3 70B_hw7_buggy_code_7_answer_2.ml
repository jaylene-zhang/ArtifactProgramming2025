Here is the corrected code:

```ocaml
let string_implode (l : char list) : string =
  List.fold_right (fun x acc -> String.concat "" [x;acc]) l ""
```