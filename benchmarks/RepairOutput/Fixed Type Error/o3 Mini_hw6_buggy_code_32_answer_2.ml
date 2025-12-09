let seq_predicate2 (p1 : 'a1 -> 'b1 Maybe.t)
                   (p2 : 'a2 -> 'b2 Maybe.t)
                   ((x, y) : ('a1 * 'a2)) : ('b1 * 'b2) Maybe.t =
  p1 x >>= fun r1 ->
  p2 y >>= fun r2 ->
  Maybe.return (r1, r2)
;;