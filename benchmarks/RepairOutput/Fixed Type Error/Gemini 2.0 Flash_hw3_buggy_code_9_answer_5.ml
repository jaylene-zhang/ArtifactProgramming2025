```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun z s -> n2 z (n1 z s)
```