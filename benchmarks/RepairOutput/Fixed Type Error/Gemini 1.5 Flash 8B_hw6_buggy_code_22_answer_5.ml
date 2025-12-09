```ocaml
(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (x1, x2) ->
  Maybe.bind p1 (fun y1 ->
    Maybe.bind p2 (fun y2 ->
      return (y1, y2)
    )
  )
```
