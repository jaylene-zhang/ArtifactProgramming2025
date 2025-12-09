```
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (x, y) -> 
    let b1 = p1 x in
    let b2 = p2 y in
    Maybe.bind b1 (fun b1' ->
      Maybe.bind b2 (fun b2' ->
        Maybe.return (b1', b2')
      )
    )
```