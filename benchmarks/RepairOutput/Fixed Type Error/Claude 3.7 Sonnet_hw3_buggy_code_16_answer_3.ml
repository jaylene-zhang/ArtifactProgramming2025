```ocaml
let sum (l : 'b church list) : 'b church =
  match l with
  | [] -> zero
  | hd :: tl -> List.fold_left add hd tl
```