let rec eval exp =
  match exp with
  | I _ -> exp
  | B _ -> exp
  | Fn _ -> exp
  | Var x -> raise (Stuck (Free_variable x))
  | Primop (po, args) ->
      let args = List.map eval args in
      begin
        match eval_op po args with
        | None -> raise (Stuck Bad_primop_args)
        | Some v -> v
      end
  | If (e, e1, e2) ->
      begin
        match eval e with
        | B true -> eval e1
        | B false -> eval e2
        | _ -> raise (Stuck If_non_true_false)
      end
  | Let (x, e1, e2) ->
      let e1 = eval e1 in
      eval (subst (e1, x) e2)
  | Rec (f, _, e) -> eval (subst (exp, f) e)
  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e_body) ->
          if List.length inputs <> List.length es then 
            raise (Stuck Arity_mismatch)
          else 
            let subs = List.combine es (List.map fst inputs) in
            eval (subst_list subs e_body)
      | _ -> raise (Stuck Apply_non_fn)