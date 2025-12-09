```ocaml
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (a, b) ->
  Maybe.bind (p1 a) (fun x -> Maybe.bind (p2 b) (fun y -> Maybe.return (x, y)))
```