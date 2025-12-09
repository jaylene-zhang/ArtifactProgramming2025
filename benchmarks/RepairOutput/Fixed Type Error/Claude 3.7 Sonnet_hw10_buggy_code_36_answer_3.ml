The error is in the `Apply` case of the `eval` function. The line `eval (subst_list []::es e)` is trying to use the `::` constructor which is for lists, but it's incorrectly placed. The first argument to `subst_list` should be a list of substitutions.

Here's the fixed code:

```ocaml
  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs != List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else 
            let evaluated_es = List.map eval es in
            let substitutions = List.combine evaluated_es (List.map fst inputs) in
            eval (subst_list substitutions e)
      | _ -> raise (Stuck Apply_non_fn)
```