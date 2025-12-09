```OCaml
(* TODO: Implement the missing cases of infer. *)
let rec infer ctx e =
  match e with
  | Var x ->
      begin
        try lookup x ctx
        with Not_found -> raise (TypeError (Free_variable x))
      end
  | I _ -> Int
  | B _ -> Bool
  | Primop (po, exps) ->
      let (domain, range) = primopType po in
      check ctx exps domain range
  | If (e, e1, e2) ->
      begin
        match infer ctx e with
        | Bool ->
            let t1 = infer ctx e1 in
            let t2 = infer ctx e2 in
            if t1 = t2 then t1
            else raise (TypeError (Type_mismatch (t1, t2)))
        | t -> raise (TypeError (Type_mismatch (Bool, t)))
      end
  | Let (x, e1, e2) ->
      let t1 = infer ctx e1 in
      infer (extend ctx (x, t1)) e2
  | Rec (f, t, e) ->
      let ctx' = extend ctx (f, t) in
      let t' = infer ctx' e in
      if t = t' then t else raise (TypeError (Type_mismatch (t, t')))
  | Fn (xs, e) ->
      let ctx' = extend_list ctx xs in
      let ts = List.map (fun (_, t) -> t) xs in
      let t = infer ctx' e in
      Arrow (ts, t)
  | Apply (e, es) ->
      let t' = infer ctx e in
      begin
        match t' with
        | Arrow (ts, t) ->
            let rec check_args i = function
              | [] -> ()
              | e :: es ->
                  let te = infer ctx e in
                  if te = ts.(i) then check_args (i + 1) es
                  else raise (TypeError (Type_mismatch (ts.(i), te)))
            in
            check_args 0 es;
            t
        | _ -> raise (TypeError (Apply_non_arrow t'))
      end
and check ctx exps tps result =
  match exps, tps with
  | [], [] -> result
  | e :: es, t :: ts ->
      let t' = infer ctx e in
      if t = t' then check ctx es ts result
      else raise (TypeError (Type_mismatch (t, t')))
  | _ -> raise (TypeError Arity_mismatch)
```