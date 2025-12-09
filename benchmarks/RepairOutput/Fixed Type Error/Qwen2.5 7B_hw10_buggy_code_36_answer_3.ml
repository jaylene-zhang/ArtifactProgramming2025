```ocaml
| Apply (e, es) -> 
    match eval e with
    | Fn (inputs, e) -> 
        if List.length inputs <> List.length es then 
            raise (Stuck Arity_mismatch)
        else 
            eval (subst_list (List.map (fun (x, _) -> (x, fres)) inputs) es e)
    | _ -> raise (Stuck Apply_non_fn)
```

Note: The `fres` in `fres` is a placeholder and should be replaced with the actual function to generate fresh names. If `fres` is defined elsewhere, you should use the correct function call.