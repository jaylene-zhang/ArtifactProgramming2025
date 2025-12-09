The issue is in the implementation of `seq_predicate2`. The function needs to apply `p1` and `p2` to the components of a pair and then combine the results.

```ocaml
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (x1, x2) ->
    p1 x1 >>= fun y1 ->
    p2 x2 >>= fun y2 ->
    Maybe.return (y1, y2)
;;
```