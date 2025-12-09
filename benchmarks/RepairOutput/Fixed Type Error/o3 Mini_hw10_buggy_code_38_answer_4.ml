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
            else type_mismatch t1 t2
        | t -> type_mismatch Bool t
      end

  | Let (x, e1, e2) ->
      let t1 = infer ctx e1 in
      infer (extend ctx (x, t1)) e2

  | Rec (f, t, e) -> 
      let ctx' = extend ctx (f, t) in
      let t' = infer ctx' e in
      if t = t' then t else type_mismatch t t'

  | Fn (xs, e) -> 
      let ctx' = extend_list ctx xs in
      let ts = List.map (fun (_, t) -> t) xs in
      let t = infer ctx' e in
      Arrow (ts, t)

  | Apply (e, es) -> 
      let t' = infer ctx e in
      match t' with
      | Arrow (ts, t) -> 
          begin
            List.iter2 (
              fun t e ->
                let t' = infer ctx e in
                if t != t' then
                  type_mismatch t t'
                else
                  ()
            ) ts es;
            t
          end
      | _ -> raise (TypeError (Apply_non_arrow t'))

and check ctx exps tps result =
  match exps, tps with
  | [], [] -> result
  | e :: es, t :: ts ->
      let t' = infer ctx e in
      if t = t' then check ctx es ts result
      else type_mismatch t t'
  | _ -> raise (TypeError Arity_mismatch)