let rec eval exp =
  match exp with
  | I _ -> exp
  | B _ -> exp
  | Fn _ -> exp
  | Var x -> raise (Stuck (Free_variable x))
  | Primop (po, args) ->
      let args = List.map eval args in
      (match eval_op po args with
       | None -> raise (Stuck Bad_primop_args)
       | Some v -> v)
  | If (e, e1, e2) ->
      (match eval e with
       | B true -> eval e1
       | B false -> eval e2
       | _ -> raise (Stuck If_non_true_false))
  | Let (x, e1, e2) ->
      let e1_eval = eval e1 in
      eval (subst (e1_eval, x) e2)
  | Rec (f, _, e) ->
      eval (subst (exp, f) e)
  | Apply (e, es) ->
      (match eval e with
       | Fn (inputs, e_body) ->
           if List.length inputs <> List.length es then
             raise (Stuck Arity_mismatch)
           else
             let arg_vals = List.map eval es in
             let subs = List.map2 (fun (x, _) arg -> (arg, x)) inputs arg_vals in
             eval (subst_list subs e_body)
       | _ -> raise (Stuck Apply_non_fn))