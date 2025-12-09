```haskell
let rec eval exp =
  match exp with
  (* Values evaluate to themselves *)
  | I _ -> exp
  | B _ -> exp
  | Fn _ -> exp
  (* variables should be substituted away *)
  | Var x -> raise (Stuck (Free_variable x))

  (* Primitive operations: +, -, *, <, = *)
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

  | Rec (f, _, e) -> 
      let type_env = empty in
      eval (subst (exp, f) e)

  | Apply (e, es) -> 
      match eval e with
      | Fn (inputs, e) -> 
          let args_env = List.fold_right (fun (name, tp) context ->
              extend context (name, tp)) inputs empty in
          if (List.length inputs != List.length es) 
             then raise (Stuck Arity_mismatch) 
             else 
             eval (subst_list_list e args_env es)
      | _ -> raise (Stuck Apply_non_fn)
and subst_list_list e env args =
  match args with
  | [] -> e
  | arg :: args ->
      let arg_env = eval arg in
      subst_list (e, List.hd (List.rev env)) (List.rev args)
and subst_list e env =
  match env with
  | (name, tp) :: env ->
      subst (eval (Var name), name) (subst_list e env)
  | [] -> e
```