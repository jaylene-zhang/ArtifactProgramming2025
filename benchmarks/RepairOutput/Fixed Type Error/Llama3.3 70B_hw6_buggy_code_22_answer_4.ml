Here is the fixed code:

```
let seq_predicate2
    (p1 : 'a -> 'b Maybe.t)
    (p2 : 'a -> 'b Maybe.t) : 'a -> ('b * 'b) Maybe.t =
  fun x ->
  Maybe.bind (p1 x) (fun x -> Maybe.bind (p2 x) (fun y -> return (x, y)))
```