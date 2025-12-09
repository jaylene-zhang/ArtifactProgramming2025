```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun n s -> n1 n (n2 n s)
```