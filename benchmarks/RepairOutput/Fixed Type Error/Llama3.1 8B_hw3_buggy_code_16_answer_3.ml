```hindler
let sum (l : 'a church list) : 'a church =
  List.fold_left (fun acc x -> add x acc) zero l
```