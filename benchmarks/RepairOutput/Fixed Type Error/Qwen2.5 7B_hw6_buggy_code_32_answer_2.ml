let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (a1, a2) -> 
    p1 a1 >>= (fun b1 -> 
      p2 a2 >>= (fun b2 -> 
        return (b1, b2)))
;;