```ocaml
(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (a1, a2) ->
    Maybe.bind (p1 a1) (fun x1 ->
      Maybe.bind (p2 a2) (fun x2 ->
        Maybe.return (x1, x2)
      )
    )
```