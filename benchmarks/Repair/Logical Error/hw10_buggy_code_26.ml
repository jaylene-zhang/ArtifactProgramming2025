(* TODO: Write a good set of tests for eval. *)

let varXis0 =(Primop (Equals, [Var "x"; I 0]))
let varXplus1 =(Primop (Plus, [Var "x"; I 1]))
let varXplusvarY =(Primop (Plus, [Var "x"; Var "y"]))
let xminus1 = (Primop (Minus, [Var "x"; I 1])) 
let ifStatement = If(varXis0, I 1, Apply(Var "f", [xminus1]))
let ifStatement2 = If(varXis0, Apply(Var "f", [xminus1]), Apply(Var "f", [varXplus1]))
let myFunction= Rec("f", (Arrow ([Int],Int)), Fn (["x",Int], ifStatement) ) 
let tryifStatement = If(varXis0, I 1, Apply(Var "g", [xminus1]))
let trymyFunction= Rec("f", (Arrow ([Int],Int)), Fn (["x",Int], tryifStatement) ) 
let trymyFunctionTest5= Rec("f", (Arrow ([Int],Int)), Fn (["x",Int], varXplus1) ) 
    
let fni = Fn( [("x", Int)], ifStatement2)
      
let trymyFunctionTest6= Rec("f", (Arrow ([Int],Int)), fni ) 
    
    
let myF = Fn(["x", Int],  varXplus1)
let myF2 = Fn([("x", Int);("y", Int)],  varXplusvarY) 
let manyVar = Primop(Plus, [Var "f"; Var "f"])
    
let input = (Rec("f", (Arrow ([Int],Int)),  Fn( [("x", Int)], If(varXis0, Apply(Var "f", [I 2]), I 0)) ))
let output = (Fn ([("x", Int)],
                  If (Primop (Equals, [Var "x"; I 0]),
                      Apply
                        (Rec ("f", Arrow ([Int], Int),
                              Fn ([("x", Int)],
                                  If (Primop (Equals, [Var "x"; I 0]), Apply (Var "f", [I 2]), I 0))),
                         [I 2]),
                      I 0))) 
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6)
]

(* TODO: Implement the missing cases of eval. *)
let rec eval exp =
  match exp with
  (* Values evaluate to themselves *)
  | I v -> I v 
  | B v -> B v
  | Fn (xs,e) -> Fn(xs, e)

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
      let e = subst (( Rec (f, t, e)), f ) e in
      eval e

  | Apply (e, es) -> 
      (
        match eval e with 
        |Fn ( xs, e) -> (
            let compareLists = List.compare_lengths xs es in
            if compareLists!=0 then
              raise (Stuck Arity_mismatch)
            else(
              let evaluatedList = List.map (eval) es in 
              (
                match List.split xs with
                |(x,y) -> 
                    let newList = List.combine evaluatedList x in 
                    eval (subst_list newList e)
              )
            )
          )
        |_ -> raise (Stuck Apply_non_fn)
      ) 
      

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (([("x", Int)], Var "x"), Int)
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

  | Rec (f, t, e) -> raise NotImplemented

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
