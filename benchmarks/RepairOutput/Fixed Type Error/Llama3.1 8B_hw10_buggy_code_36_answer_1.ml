```haskell
let rec eval exp =
  match exp with
  | I _ -> exp
  | B _ -> exp
  | Fn _ -> exp

  (* ... (rest of the code remains the same)

  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e) -> 
          if (List.length inputs != List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
          else 
            eval (List.fold_left (fun acc arg -> subst (arg, List.nth inputs (List.index_of arg es)) acc) e es)
      | _ -> raise (Stuck Apply_non_fn)
```