```ocaml
let sum (l : 'b church list) : 'b church =
  List.fold_left add zero l
```