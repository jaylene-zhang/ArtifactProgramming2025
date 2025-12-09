``` OCaml
let seq_predicate2 
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun arg -> bind (p2 (snd arg) ) (fun (x2 ,  _ ) -> bind (p1 (fst arg ) ) (fun (x1 ,  _ ) -> return (x1 ,  x2 )))
;; 
```