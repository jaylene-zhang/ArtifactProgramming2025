```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun x s -> s (n1 x s)
```
