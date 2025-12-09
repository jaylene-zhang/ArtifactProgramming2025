Here's the fixed code:

```ocaml
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (a1, a2) ->
    p1 a1 >>= fun b1 ->
    p2 a2 >>= fun b2 ->
    Maybe.return (b1, b2)
```

Note that the original code was applying `p1` to `p2`, which is not the correct way to sequence the two predicates. Instead, we use a lambda function that takes a pair of values `a1` and `a2`, applies `p1` and `p2` to them respectively, and then combines the results using `Maybe.return`.