```ocaml
(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6) ;
  (Apply (Fn ([], I 1), []), I 1);
  (Apply (Fn ([("a", Bool)], Var "a"), [B true]), B true); 
  (Rec ("a", Bool, Fn ([("b", Bool)], Var "a")), Fn ([("b", Bool)], Rec ("a", Bool, Fn ([("b", Bool)], Var "a"))));
  (Apply (Fn ([("a", Int); ("b", Bool)], Var "a"), [I 1; B true]), I 1); 
  (Apply (Rec ("a", Arrow ([Bool], Int), Fn ([("b", Bool)], If (Var "b", I 1, Apply (Var "a", [B false])))), [B true]), I 1); 
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

  | Rec (f, _, e) -> eval (subst (Rec (f, _, e), f, e))

  | Apply (e, es) ->
      let find x = match x with 
        | (y, _) -> y 
      in
      match eval e with
      | Fn (names, z) -> 
          begin
            let s = try List.combine (List.map eval es) (List.map find names) 
              with Invalid_argument _ -> raise (Stuck Arity_mismatch)
            in eval (subst_list s z)
          end
      | _ -> raise (Stuck Apply_non_fn)

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (([("x", Int)], Var "x"), Int);
  (([], Apply (Fn ([], B false), [])), Bool);
  (([], Fn ([("a", Bool)], Var "a")), Arrow ([Bool], Bool));
  (([], Apply (Fn ([("a", Bool); ("b", Int)], Var "a"), [B true;I 4])), Bool);
  (([], Apply (Fn ([("a", Int)], Var "a"), [I 4])), Int);
  (([], Fn ([("a", Bool); ("b", Int)], Var "a")), Arrow ([Bool; Int], Bool));
  (([], Rec ("a", Arrow ([], Int), Fn ([], If (B false, I 96, Apply (Var "a", []))))), Arrow ([], Int));
  (([("a", Bool)], Fn ([], Var "a")), Arrow ([],Bool));
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
      let z = infer ctx e1 in infer (extend ctx (x, z)) e2

  | Rec (f, t, e) -> 
      let t1 = infer (extend ctx (f, t)) e in
      if t1 = t then t else type_mismatch t t1

  | Fn (xs, e) -> 
      let find_type el = match el with (_, x) -> x in
      let tn = infer (extend_list ctx xs) e in
      Arrow (List.map find_type xs, tn)

  | Apply (e, es) -> 
      let rec compare x y tn = 
        match x, y with
        | [], [] -> tn
        | x1 :: y1, x2 :: y2 -> 
            if x1 = x2 
            then compare y1 y2 tn 
            else type_mismatch x1 x2 
        | _ -> raise (TypeError Arity_mismatch)
      in 
      match infer ctx e with 
      | Arrow (xn, tn) -> compare xn (List.map (infer ctx) es) tn
      | tx -> raise (TypeError (Apply_non_arrow tx))

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
        unify type_substitution t1 t2
  
    | UCross ts1, UCross ts2 ->
        unify type_substitution (UCross (List.tl ts1)) (UCross (List.tl ts2))
        
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
    if occurs t then unif_error (OccursCheck (UTVar a, t))
    else UTVarMap.add a t type_substitution
  in
  fun t1 t2 -> unify UTVarMap.empty t1 t2
```