(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Rec ("f", Arrow ([Bool], Bool), Fn ([], Var "f")), 
   Fn ([], Rec ("f", Arrow ([Bool], Bool), Fn ([], Var "f")))); 
  (Rec ("f", Arrow ([Int], Int), Primop (Plus, [I 10; I 7])), I 17); 
  (Apply (Fn ([("a", Int); ("b", Int)], Primop (Plus, [Var "a"; Var "b"])), [Primop (Minus, [I 5; I 2]); Primop (Times, [I 0; I 0])]), I 3); 
  (Apply (Fn ([("a", Bool)], Var "a"), [B true]), B true); 
  (Apply (Let ("a", I 10, Fn ([("b", Int)], Primop (Minus, [Var "a"; Var "b"]))), [I 7]), I 3); 
  (Apply (Fn ([], B true), []), B true); 
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

  | Rec (f, _, e) -> eval (subst (exp, f) e)

  | Apply (e, es) -> match eval e with
    | Fn (l1, e) ->
        if List.length l1 <> List.length es then 
          raise (Stuck Arity_mismatch)
        else if List.length l1 = List.length es then 
          let l1 = List.map fst l1 in 
          let es = List.map eval es in 
          let combined = List.combine es l1 in 
          eval (subst_list combined e)
        else 
          raise (Stuck Arity_mismatch) 
    | _ -> raise (Stuck Apply_non_fn)

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *) 
  (([], Rec ("f", Arrow ([Bool], Bool), Var "f")), Arrow ([Bool], Bool)); 
  (([("f", Arrow ([], Int))], Apply (Var "f", [])), Int); 
  (([("f", Arrow ([Bool], Bool))], Apply (Var "f", [B true])), Bool); 
  (([("f", Arrow ([Bool; Bool; Bool], Bool))], Apply (Var "f", [B true; B true; B true])), Bool);
  (([], Fn ([("a", Bool); ("b", Bool); ("c", Bool)], B true)), Arrow ([Bool; Bool; Bool], Bool)); 
  (([], Fn (["a", Int], Fn (["a", Int], Var "a"))), Arrow ([Int], Arrow ([Int], Int)));
  (([], Fn ([], I 0)), Arrow ([], Int)); 
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
      let ctx2 = extend ctx (f, t) in
      let t2 = infer ctx2 e in
      if t2 = t then t
      else type_mismatch t t2

  | Fn (xs, e) ->   
      let l1 = List.map snd xs in
      let ctx2 = extend_list ctx xs in 
      Arrow (l1, infer ctx2 e)

  | Apply (e, es) -> match infer ctx e with 
    | Arrow (l1, t) -> check ctx es l1 t
    | t2 -> raise (TypeError (Apply_non_arrow t2)) 

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
        let subst' = unify type_substitution t1 t2 in
        unify subst' t1' t2'

    | UCross ts1, UCross ts2 ->
        raise NotImplemented

    | UTVar a, _ -> unifyVar type_substitution a t2
    | _, UTVar b -> unifyVar type_substitution b t1
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
    unif_error (UnifOccursCheckFails)

  in
  fun t1 t2 -> unify UTVarMap.empty t1 t2
