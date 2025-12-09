```ocaml
(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  
  (Rec ("f", Bool, Primop (Equals, [I 1 ; I 1])), B true);
  
  (Rec ("f", Arrow ([Int; Bool], Bool), (Fn ([("x", Int); ("y", Bool)], B true))), (Rec ("f", Arrow ([Int; Bool], Bool), (Fn ([("x", Int); ("y", Bool)], B true)))));
  
  (Apply (Fn ([("x", Int)],Primop (Plus, [Var "x" ; I 1])), [I 3]), I 4);
  
  (Apply (Fn ([("x", Int)],Primop (Plus, [Var "x" ; I 1])), [Primop (Plus, [I 1 ; I 1])]), I 3);
  
  (Apply (Fn ([("x", Int); ("y", Int)],Primop (Plus, [Var "x" ; Var "y"])), [I 3; I 5]), I 8);

  (Apply (Fn ([],Primop (Plus, [I 1 ; I 1])), []), I 2);
  
  (Apply (Apply (Fn ([("x", Int)], Fn ([("y", Int)], Primop (Plus, [Var "x"; Var "y"]))), [I 3]) , [I 5]), I 8);
  
  (Apply (Fn ([("f", Arrow ([], Int))], Apply (Var "f", [])) , [Fn ([], Primop (Plus, [I 1; I 1])) ]), I 2)
]

(* TODO: Implement the missing cases of eval. *)
let rec eval exp =
  match exp with
  (* Values evaluate to themselves *)
  | I _ -> exp
  | B _ -> exp
  | Fn _ -> exp

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

  | Rec (f, t, e) -> eval (subst (Rec (f, t, e), f) e)

  | Apply (e, es) -> 
      match eval e with 
      | Fn (nts, e1) ->
          let vs = List.map eval es in 
          let xs = List.map fst nts in
          (try 
             let vxs = List.combine xs vs in 
             eval (subst_list vxs e1)
           with Invalid_argument _ -> raise (Stuck Arity_mismatch))
      | _ -> raise (Stuck Apply_non_fn)

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (([("x", Int)], Var "x"), Int);
  
  (([("x", Int)], (Rec ("f", Bool, Primop (Equals, [Var "x" ; I 1])))), Bool);

  (([("f", Int)], (Rec ("f", Bool, Var "f"))), Bool);

  (([], (Rec ("f", Arrow ([Int; Bool], Bool), (Fn ([("x", Int); ("y", Bool)], B true))))), Arrow ([Int; Bool], Bool));

  (([], Fn ([],Primop (Plus, [I 1 ; I 1]))), Arrow ([], Int));
  
  (([("x", Int)], Fn ([("x", Int)],Primop (Plus, [Var "x" ; I 1]))), Arrow ([Int], Int));
  
  (([("x", Int); ("y", Int)], Fn ([("x", Int); ("y", Int)],Primop (Plus, [Var "x" ; Var "y"]))), Arrow ([Int; Int], Int));
  
  (([], Apply(Fn ([],Primop (Plus, [I 1 ; I 1])), [])), Int);
  
  (([("x", Int); ("y", Int)], Apply(Fn ([("x", Int); ("y", Int)],Primop (Plus, [Var "x" ; Var "y"])), [I 5; I 4])), Int);
  
  (([("x", Int)], Apply(Fn ([("x", Int)],Primop (Plus, [Var "x" ; I 1])), [I 4])), Int);
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
      let t1 = infer (extend ctx (f, t)) e in
      if t = t1 then t
      else type_mismatch t t1
  
  | Fn (xs, e) -> 
      let t1 = infer (extend_list ctx xs) e in
      Arrow (List.map snd xs, t1)

  | Apply (e, es) -> 
      match infer ctx e with
      | Arrow (tps, tp) -> 
          if List.length tps = List.length es 
          then 
            List.iter2 
              (fun t e' -> 
                 let t' = infer ctx e' in 
                 if t <> t' then type_mismatch t t') 
              tps es;
            tp
          else raise (TypeError Arity_mismatch)
      | t -> raise (TypeError (Apply_non_arrow t))

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
    | UInt, UInt
    | UBool, UBool -> type_substitution
    | UTVar a, UTVar a' when a = a' -> type_substitution
    | UArrow (t1, t1'), UArrow (t2, t2') ->
        unify (unify type_substitution t1 t2) t1' t2'
    | UCross ts1, UCross ts2 ->
        List.fold_left2 unify type_substitution ts1 ts2
    | UTVar a, _ -> unifyVar type_substitution a t2
    | _, UTVar b -> unifyVar type_substitution b t1
    | _, _ -> unif_error @@ UnifMismatch (t1, t2)
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
    if occurs t 
    then unif_error @@ UnifOccursCheck (a, t) 
    else UTVarMap.add a t type_substitution
  in
  fun t1 t2 -> unify UTVarMap.empty t1 t2
```