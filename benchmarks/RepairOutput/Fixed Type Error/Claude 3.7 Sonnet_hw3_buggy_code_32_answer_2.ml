```ocaml
let mult (n1 : 'b church) (n2 : 'b church) : 'b church = fun z s -> n2 z (fun x -> n1 x s)
```