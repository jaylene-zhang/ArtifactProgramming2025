The error is in the `Apply` case where `subst_list []::es e` is used incorrectly. The constructor `::` is for list construction but is being used directly in an expression context. Here's the fixed code:

```ocaml
  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs != List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else
            let evaluated_es = List.map eval es in
            let arg_pairs = List.combine (List.map (fun (x, _) -> x) inputs) evaluated_es in
            eval (subst_list arg_pairs e)
      | _ -> raise (Stuck Apply_non_fn)
```