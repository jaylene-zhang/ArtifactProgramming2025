```
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (a1, a2) ->
    let mb1 = p1 a1 in
    let mb2 = p2 a2 in
    Maybe.bind mb1 (fun b1 ->
    Maybe.bind mb2 (fun b2 ->
    Maybe.return (b1, b2)))
```