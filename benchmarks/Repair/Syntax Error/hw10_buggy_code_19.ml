(* TODO: Write a good set of tests for eval. *)


let sum =
  Rec("f", Arrow([Int;Int],Int), 
      Fn([("x", Int);("y", Int)],
         If(Primop(Equals,[Var "x"; Var "y"]),
            I 0,
            Primop(Plus,
                   [Primop(Plus,[Var "x";Var "y"]) ;
                    Apply( Var "f", [Primop(Minus,[Var "x"; I 1]); Var "y"])])
           )
        )
     )
    
let fact = Let ("g",
                Rec ("fact_tr", Arrow ([Int], Int),
                     Fn ([("x", Int)],
                         Let ("aux",
                              Rec ("aux", Arrow ([Int; Int], Int),
                                   Fn ([("n", Int); ("acc", Int)],
                                       If (Primop (Equals, [Var "n"; I 0]), Var "acc",
                                           Let ("m", Primop (Minus, [Var "n"; I 1]),
                                                Apply (Var "aux",
                                                       [Primop (Minus, [Var "n"; I 1]);
                                                        Primop (Times, [Var "n"; Var "acc"])]))))),
                              Apply (Var "aux", [Var "x"; I 1])))),
                Apply (Var "g", [I 3]))
        
let eval_tests = [ 
  
  (*1*)
  (*2*) (Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7); 
  (*3*) (Apply(ex1, [I 2; I 2]) , I 8);
  (*4*) 
  (*5*) (Apply(Rec("f", Arrow([Int;Int],Int), 
                   Fn([("x", Int);("y", Int)],
                      If(Primop(Equals,[Var "x"; Var "y"]),
                         I 0,
                         Primop(Plus,
                                [Primop(Plus,[Var "x";Var "y"]) ;
                                 Apply( Var "f", [Primop(Minus,[Var "x"; I 1]); Var "y"])])
                        )
                     )
                  ), [I 4; I 2]), I 11);
  (*6*) (Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7); 
  
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

  | Rec (f, t, e) -> 
      subst (Rec (f, t, e),f) (eval e) 

  | Apply (e, es) ->
      match eval e with
      |Fn(l , e') -> 
          let name,_ = List.split l in 
          if List.length name != List.length es then
            raise (Stuck Arity_mismatch)
          else
            let tmp = subst_list (List.combine es name) e' in 
            eval tmp
      |Rec(f,t,e') ->  
          subst (Rec (f, t, e'),f) (eval e') 

      | _ -> raise (Stuck Apply_non_fn)

(* TODO: Write a good set of tests for infer. *) 
let infer_tests = [
  (*1*) (( [], sum) , Arrow([Int;Int],Int));
  (*2*) (([],Fn([("x", Int)], Primop(Plus, [Var "x" ; I 1]))), Arrow([Int],Int));
  (*3*) (([], Fn([("x",Int);("y", Int)], Primop(Plus, [Var "x" ; Var "y"]))), Arrow([Int;Int],Int));
  (*4*) (([], Fn([], B true)), Arrow([],Bool));
  (*5*) (([("f", Arrow([Int], Int));("x", Int)],Apply(Var "f", [Var "x"])), Int);
  (*6*) (([("f", Arrow([Int;Int], Int));("x", Int);("y",Int)],Apply(Var "f", [Var "x";Var "y"])), Int);
  (*7*) (( [], Apply( Fn([],B true), [])),Bool)
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

  | Fn (xs, e) -> 
      let ctx' = extend_list ctx xs in
      let (
        Arrow((List.fold_left (fun tup acc ->(n , t) =tup in acc @ t ) [] xs) ,infer ctx' e)

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
