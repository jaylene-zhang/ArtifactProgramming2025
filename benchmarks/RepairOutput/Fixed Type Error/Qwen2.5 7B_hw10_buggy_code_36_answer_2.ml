```ocaml
| Apply (e, es) -> 
    match eval e with
    | Fn (inputs, e) ->
        if (List.length inputs = List.length es) then 
            eval (subst_list (List.map (fun (n, t) -> (n, eval (List.nth es (List.index_of n inputs)))) inputs) e)
        else 
            raise (Stuck Arity_mismatch)
    | _ -> raise (Stuck Apply_non_fn)
```