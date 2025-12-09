The error is in the `Apply` case where I'm trying to use the `::` operator incorrectly. The issue is with the `subst_list []::es e` expression. Let me fix it:

```ocaml
  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs != List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else 
            let evaluated_args = List.map eval es in
            let substitutions = List.combine evaluated_args (List.map fst inputs) in
            eval (subst_list substitutions e)
      | _ -> raise (Stuck Apply_non_fn)
```