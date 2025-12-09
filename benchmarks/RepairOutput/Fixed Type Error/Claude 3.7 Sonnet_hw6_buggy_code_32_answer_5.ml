The issue is that the code is trying to apply `p1` to `p2`, but `p1` expects an `'a1` value, not a function. The `seq_predicate2` function should take a pair of inputs and apply each predicate to its corresponding input, then combine the results.

```ocaml
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (a1, a2) ->
    p1 a1 >>= fun b1 ->
    p2 a2 >>= fun b2 ->
    Maybe.return (b1, b2)
;;
```