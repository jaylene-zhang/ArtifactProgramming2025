```ocaml
let sum (l : 'b church list) : 'b church =
  List.fold_left (fun x y -> add x y) zero l
```