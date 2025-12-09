```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun x s -> n1 (n2 x s) s
```