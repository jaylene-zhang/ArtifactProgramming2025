```ocaml
(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (x,y) -> match p1 x with
  | Maybe.Nothing -> Maybe.Nothing
  | Maybe.Return a -> (match p2 y with
                       | Maybe.Nothing -> Maybe.Nothing
                       | Maybe.Return b -> Maybe.Return (a,b))
;;
```