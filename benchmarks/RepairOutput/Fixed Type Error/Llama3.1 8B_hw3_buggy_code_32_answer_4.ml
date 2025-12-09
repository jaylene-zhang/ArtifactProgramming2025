```ocaml
let mult (n1 : 'b church) (n2 : 'b church) : 'b church = fun z s-> n2 (fun z s-> zero (add n1  (n1 z s) s)) s
```