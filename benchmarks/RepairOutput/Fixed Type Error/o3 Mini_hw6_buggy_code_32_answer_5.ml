let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (x, y) ->
    Maybe.bind (p1 x) (fun b1 ->
      Maybe.bind (p2 y) (fun b2 ->
        Maybe.return (b1, b2)))
;;