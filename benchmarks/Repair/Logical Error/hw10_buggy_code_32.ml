(* TODO: Write a good set of tests for eval. *)
(* Fn (input z ) = (rec f = if (z = 3) then 3 else (z+1) ) evaluates *) 
let rec1test : exp = Fn (
    [("z", Int)], (Rec ("f", Int, (If ( (Primop (Equals, [Var "z"; I 3])) , (I 3), (Primop (Plus, [Var "z"; I 1])) ) ) ) ) ) 
  
let rec2test : exp = (Rec ("f", Int, ( Fn ([("x",Int)], (If (B false, Primop(Plus, [Var "x";I 1]), (I 0) ))))))
    
                     
let applyempty : exp = Fn ([], Primop (Times, [I 2;I 3]) )
let apply1: exp = Fn (["x",Int], Rec ("add1",Int, (Primop (Plus, [Var "x";I 1]) )) )
    
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  (* Apply (int 3) in 3 *)
  (Apply (ex1,[(I 3);(I 4)]), (I 25));
  (* Fn (input z = 1 ) = (rec f = if (z = 3) then 3 else (z+1) ) evaluates to 2*) 
  (Apply (rec1test,[I 1]),(I 2)); 
  (Apply (applyempty, []), (I 6) );
  (Rec ("x", Int, (
       Fn ([], If (B true, 
                   I 3, 
                   Primop (Plus, [I 1; Var "x"]) )))), 
   Fn ([], If (B true, 
               I 3, 
               Primop (Plus, [I 1; 
                              Rec ("x", Int, (Fn ([], 
                                                  If (B true, I 3, Primop (Plus, [I 1; Var "x"])))))])))); 
  (Apply (Fn (["x", Int], (Rec ("y" ,Int, I 3))),[(I 4)]), (I 3));
  (Apply (rec2test, [I 2]),(I 0));
]

let rec take n xs = match n with 
  |  0 -> []
  | _ -> List.hd xs :: take (n-1) (List.tl xs)

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

  | Rec (f, _, e) as exp -> eval (subst (exp, f) e )

  | Apply (e, es) -> match (eval e)  with
    | Fn (x, exp) -> let v2 = List.map eval es in 
        if ((List.length x) <> (List.length v2)) then raise (Stuck Arity_mismatch) else
          (* let newlist = List.combine x v2 in
           List.forall (fun ((name,tp),exp1) -> 
               match tp with
               | Arrow (x, y) -> if y = 
               | z ->
             ) newlist
          *)
          eval (subst_list (List.combine v2 (List.map fst x)) exp)
  
    | _ -> raise (Stuck Apply_non_fn)

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (([("x", Int)], Var "x"), Int);
  (([("x",Int);("y",Int)],Apply (ex1,[(I 3);(I 4)])),Int);
  (([("x",Int);], (Apply ((Fn (["x", Int],Var "x" ) ),[I 3]))),Int);
  (([("x",Int);], (Fn (["x", Int],Var "x" ))),Arrow ([Int],Int));
  (([("x",Int);("y",Int)], (Fn ([("x", Int);("y",Int)],Primop (Plus, [Var "x";Var "y"])))),Arrow ([Int;Int],Int));
  (([], (Apply (applyempty, []))),Int);
  ((["x",Int],Rec ("x", Int, (
       Fn ([], If (B true, 
                   I 3, 
                   Primop (Plus, [I 1; Var "x"]) ))))) ,Arrow ([],Int));
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

  | Rec (f, t, e) -> t

  | Fn (xs, e) -> raise NotImplemented

  | Apply (e, es) -> raise NotImplemented

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
        raise NotImplemented

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
    raise NotImplemented

  in
  fun t1 t2 -> unify UTVarMap.empty t1 t2
