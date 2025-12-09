```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun s z -> n1 (n2 s) z
```