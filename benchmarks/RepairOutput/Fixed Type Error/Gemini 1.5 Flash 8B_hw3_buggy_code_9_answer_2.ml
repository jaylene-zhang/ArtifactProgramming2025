```OCaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun s x -> s (n1 s x) (n2 s x)
```
