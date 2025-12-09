Here is the fixed code:

```ocaml
let rec eval exp =
 ...
  | Rec (f, _, e) -> eval (subst (Fn([], e), f) e)

  | Apply (e, es) -> 
      
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs!= List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else 
            eval (subst_list (List.combine (List.map fst inputs) es) e)
      | _ -> raise (Stuck Apply_non_fn)
```

I fixed two bugs:

1. In the `Rec` case, I changed `exp` to `Fn([], e)` because `exp` is not defined in this scope.
2. In the `Apply` case, I changed `subst_list []::es e` to `subst_list (List.combine (List.map fst inputs) es) e` because `subst_list` expects a list of tuples, where each tuple contains an expression and a variable. `List.combine` is used to create this list of tuples from the inputs and arguments.