```ocaml
let sum (l : 'b church list) : 'b church =
  List.fold_left (fun acc x -> add acc x) zero l
```
