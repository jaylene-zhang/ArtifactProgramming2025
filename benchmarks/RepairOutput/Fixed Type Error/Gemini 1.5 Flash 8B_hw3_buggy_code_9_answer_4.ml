```ocaml
let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun (s : 'b -> ('b -> 'b) -> 'b) (z : 'b -> 'b) ->
    n1 s z
```