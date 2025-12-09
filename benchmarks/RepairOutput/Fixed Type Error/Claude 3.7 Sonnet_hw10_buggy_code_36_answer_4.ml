The issue is in the `Apply` case where `::` is being used incorrectly in the `subst_list` call. The correct syntax should create a list of substitution pairs from the function parameters and evaluated arguments.

```ocaml
  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs != List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else 
            let evaluated_args = List.map eval es in
            let substitutions = List.map2 (fun (x, _) arg -> (arg, x)) inputs evaluated_args in
            eval (subst_list substitutions e)
      | _ -> raise (Stuck Apply_non_fn)
```