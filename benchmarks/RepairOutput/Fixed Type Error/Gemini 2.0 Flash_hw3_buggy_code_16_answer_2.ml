```ocaml
let sum (l : 'a church list) : 'a church =
  List.fold_left add zero l
```