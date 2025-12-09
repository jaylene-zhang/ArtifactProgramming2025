``` diffuse 
let seq_predicate2
    (p1 : 'a1 -> Maybe.'a1 t)
    (p2 : 'a2 -> Maybe.'a2 t) : ('a1 * 'a2) -> Maybe.('b1 * 'b2) t =
  fun (a1, a2) -> Maybe.bind (p1 a1) (fun (x1 : 'a1) -> Maybe.bind (p2 a2) (fun (x2 : 'a2) -> return (x1, x2)))
```