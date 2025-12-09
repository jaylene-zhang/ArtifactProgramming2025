The `seq_predicate2` function is supposed to sequence two predicates together, which should both be applied to a tuple of inputs and the results combined into a tuple. The current implementation is incorrect because it only uses `p1` and doesn't apply `p2` at all. Additionally, it tries to use `return` which is not in scope (it should be `Maybe.return`).

Here's the fixed code:

```ocaml
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (x1, x2) ->
    p1 x1 >>= fun b1 ->
    p2 x2 >>= fun b2 ->
    Maybe.return (b1, b2)
```