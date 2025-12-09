```haskell
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun p -> bind (p1 p |> snd) (fun q1 -> bind (p2 q1 |> snd) (fun q2 -> return (q1, q2)))
```