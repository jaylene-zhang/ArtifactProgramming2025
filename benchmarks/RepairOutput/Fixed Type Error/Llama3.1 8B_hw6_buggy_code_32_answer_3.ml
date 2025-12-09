```haskell
let seq_predicate2
    (p2 : 'a2 -> 'b2 Maybe.t)
    (p1 : 'a1 -> 'b1 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun arg -> p1 snd arg >>= fun val1 -> p2 (fst arg) >>= fun val2 -> return (val1, val2)
```