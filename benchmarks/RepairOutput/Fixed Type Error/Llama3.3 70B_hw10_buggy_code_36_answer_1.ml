```ocaml
| Apply (e, es) -> 
    let e = eval e in
    match e with
    | Fn (inputs, e) -> 
        if (List.length inputs!= List.length es) then 
          raise (Stuck Arity_mismatch) (*incorrect number of arguments*)
        else 
          eval (subst_list (List.combine (List.map (fun x -> Var x) (List.map fst inputs)) es) e)
    | _ -> raise (Stuck Apply_non_fn)
```