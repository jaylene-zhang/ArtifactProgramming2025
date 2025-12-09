Here's the fixed code:

```ocaml
let rec eval exp =
 ...
  | Rec (f, _, e) -> eval (subst (exp, f) e)

  | Apply (e, es) -> 
      
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs!= List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else 
            eval (subst_list (List.combine inputs es) e)
      | _ -> raise (Stuck Apply_non_fn)
```