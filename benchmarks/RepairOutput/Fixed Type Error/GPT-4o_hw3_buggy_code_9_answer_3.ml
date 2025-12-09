```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  let added: 'b church = fun z s -> n1 (n2 z s) s in added
```