```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun b s -> n1 (n2 b s) s
```