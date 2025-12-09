```
let seq_predicate2 
    (p1 : 'a1 -> 'b1 Maybe.t) 
    (p2 : 'a1 -> 'b2 Maybe.t) : 'a1 -> ('b1 * 'b2) Maybe.t = 
  fun a1 -> 
    Maybe.bind (p1 a1) (fun x -> 
        Maybe.bind (p2 a1) (fun y -> 
            return (x, y)))
```