``` ocaml
let rec add (n1 : 'b church) (n2 : 'b church) : 'b = 
  fun z -> n1 z (fun z -> n2 z (fun z -> z))
```