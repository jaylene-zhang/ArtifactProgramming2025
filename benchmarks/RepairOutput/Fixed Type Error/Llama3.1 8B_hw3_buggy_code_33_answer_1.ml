```ocaml
let rec add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z -> n2 (n1 z (fun x -> x + 1)) (fun z -> z)
```