```ocaml
(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  (Apply (Fn([("x", Int)], Primop(Plus, [Var "x"; I 2])), [I 1]), I 3); (* #2 & #6 *)
  (Apply (Fn([("x", Int); ("y", Int)], Primop(Plus, [Var "x"; Var "y"])), [I 1; I 4]), I 5);  (* #3 *)
  (Rec ("f", Int, I 2), I 2); (* #1 *)
  (Rec ("f", Int, Let("f", I 1, I 3)), I 3);
  (Rec ("f", Int, Let("f", I 1, Var "f")), I 1);
]

(* TODO: Implement the missing cases of eval. *)
let rec eval exp =
  match exp with
  (* Values evaluate to themselves *)
  | I _ -> exp
  | B _ -> exp
  | Fn _ -> exp

  (* This evaluator is _not_ environment-based. Variables should never
     appear during evaluation since they should be substituted away when
     eliminating binding constructs, e.g. function applications and lets.
     Therefore, if we encounter a variable, we raise an error.
*)
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

  | Rec (f, t, e) -> eval (subst (Rec(f, t, e), f) e)

  | Apply (e, es) -> let e2 = eval e in
      begin match e2 with
        | Fn (l, e3) -> 
            let es2 = List.map eval es in 
            if List.length l <> List.length es2 then
              raise (Stuck Apply_non_fn)
            else
              let l2 = List.map fst l in 
              eval (subst_list (List.combine l2 es2) e3)
        | _ -> raise (Stuck Apply_non_fn)
      end
      

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (([("x", Int)], Var "x"), Int);
  (([("x", Int)], Fn([], I 2)), Arrow([], Int)); (* #4 *)
  (([("x", Int)], Fn([("x", Int)], I 2)), Arrow([Int], Int)); (* #2 *)
  (([("x", Int)], Fn([("x", Int); ("y", Int)], I 2)), Arrow([Int; Int], Int)); (* #3 *)
  (([("x", Int)], Apply(Fn([("x", Int)], Primop(Plus, [Var "x"; I 2])), [I 3])), Int); (* #5 *)    
  (([("x", Int)], Apply(Fn([("x", Int); ("y", Int)], Primop(Plus, [Var "x"; Var "y"])), [I 3; I 4])), Int); (* #6 *)
  (([("x", Int)], Rec("x", Int, Primop(Plus, [Var "x"; I 2]))), Int);
  (([("x", Int)], Rec("x", Bool, Var "x")), Bool); (* #1 *)
]

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
            else type_mismatch t1 t2
        | t -> type_mismatch Bool t
      end

  | Let (x, e1, e2) ->
      let t1 = infer ctx e1 in
      infer (extend ctx (x, t1)) e2

  | Rec (f, t, e) -> 
      let ctx' = extend ctx (f, t) in
      let t' = infer ctx' e in
      if t = t' then t
      else type_mismatch t t'

  | Fn (xs, e) -> 
      let ctx' = extend_list ctx xs in
      let ts = List.map snd xs in
      Arrow(ts, infer ctx' e)

  | Apply (e, es) -> 
      let t = infer ctx e in
      begin match t with
        | Arrow (tp_args, tp_res) -> 
            if List.length tp_args = List.length es then
              List.iter2 (fun e_arg tp_arg ->
                let tp_e = infer ctx e_arg in
                if tp_e <> tp_arg then type_mismatch tp_arg tp_e
              ) es tp_args;
              tp_res
            else raise (TypeError Arity_mismatch)
        | _ -> raise (TypeError Apply_non_arrow t)
      end

and check ctx exps tps result =
  match exps, tps with
  | [], [] -> result
  | e :: es, t :: ts ->
      let t' = infer ctx e in
      if t = t' then check ctx es ts result
      else type_mismatch t t'
  | _ -> raise (TypeError Arity_mismatch)

(* TODO: Implement type unification. *)
let unify : utp -> utp -> utp UTVarMap.t =
  let rec unify (type_substitution : utp UTVarMap.t) (t1 : utp) (t2 : utp) : utp UTVarMap.t =
    match t1, t2 with
    (* Unifying identical concrete types does nothing *)
    | UInt, UInt
    | UBool, UBool -> type_substitution
    | UTVar a, UTVar a' when a = a' -> type_substitution

    (* For type constructors, recursively unify the parts *)
    | UArrow (t1, t1'), UArrow (t2, t2') ->
        unify (unify type_substitution t1 t2) t1' t2'

    | UCross ts1, UCross ts2 ->
        List.fold_left2 unify type_substitution ts1 ts2

    | UTVar a, t
    | t, UTVar a -> unifyVar type_substitution a t
    (* All other cases are mismatched types. *)
    | _, _ -> unif_error @@ UnifMismatch (t1, t2)
  
  (* Unify a variable with a type *)
  and unifyVar (type_substitution : utp UTVarMap.t) (a : string) (t : utp) : utp UTVarMap.t =
    let rec occurs : utp -> bool = function
      | UInt | UBool -> false
      | UArrow (t1, t2) -> occurs t1 || occurs t2
      | UCross ts -> List.exists occurs ts
      | UTVar b ->
          if a = b
          then true
          else
            match UTVarMap.find_opt b type_substitution with
            | None -> false
            | Some t' -> occurs t'
    in
    if occurs t then
      unif_error @@ OccursCheck (a, t)
    else
      UTVarMap.add a t type_substitution
  in
  fun t1 t2 -> unify UTVarMap.empty t1 t2
```