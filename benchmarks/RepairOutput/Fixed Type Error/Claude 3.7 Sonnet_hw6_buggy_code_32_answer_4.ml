The issue is that `seq_predicate2` should take a pair of arguments `('a1 * 'a2)` and apply each predicate to the corresponding part of the pair, then combine the results. Here's the fixed version:

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