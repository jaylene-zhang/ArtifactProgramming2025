```ocaml
let seq_predicate2
  (p1 : ('a1 -> 'b1 Maybe.t))
  (p2 : ('a2 -> 'b2 Maybe.t)) : (('a1 * 'a2) -> ('b1 * 'b2) Maybe.t) =
  fun (x : 'a1 * 'a2) ->
  Match (p1 (fst x), p2 (snd x)) with
  | (Nothing, _) -> Nothing
  | (Just (x1, _), Just (x2, _)) -> return (x1, x2)
  | (_, Just _) | (_, Nothing) -> Nothing
```