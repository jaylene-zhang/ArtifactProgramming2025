```ocaml
| Apply (e, es) -> 
    match eval e with
    | Fn (inputs, e) -> 
        if (List.length inputs <> List.length es) then 
            raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
        else 
            eval (subst_list (List.map (fun (_, x) -> (x, hd es)) inputs) e)
    | _ -> raise (Stuck Apply_non_fn)
```