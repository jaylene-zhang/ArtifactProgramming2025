```haskell
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun x -> Maybe.bind (p1 (fst x)) (fun x1 -> Maybe.bind (p2 (snd x)) (fun x2 -> return (x1, x2)))
```