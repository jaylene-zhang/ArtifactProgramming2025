```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun s x -> n1 s (n2 s x)
```
