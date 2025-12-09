```ocaml
let mult (n1 : 'b church) (n2 : 'b church) : 'b module = 
  fun pledging_function stopping_function-> 
    match n2 with
      | Zero -> n1
      | Succ n -> mult n1 (Succ n)
```