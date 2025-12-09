```ocaml
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  Maybe.bind (fun (x, _) -> p1 x) (fun _ -> p2 Ducks.)
```
This code will fix the error by correctly composing the binary function `p1` with the pattern matching lambda expressions to ignore the second component `(fun _ -> p2 Ducks.)` and bind results from `p1`.