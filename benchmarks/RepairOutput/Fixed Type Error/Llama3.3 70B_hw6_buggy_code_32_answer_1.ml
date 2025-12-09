```
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (x1, x2) -> 
    p1 x1 >>= fun b1 -> 
    p2 x2 >>= fun b2 -> 
    Maybe.return (b1, b2)
```