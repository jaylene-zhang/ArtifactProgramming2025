(**To DO: Write a good set of tests for free_variables **)
let free_variables_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Let, Rec, Fn, and Apply!
  *)
  ( Let ("x", I 1, I 5), []); 
  ( Let("x", Var("y"), Primop(Plus, [Var("x"); Var("c")])), ["y"; "c"] );
  ( Fn ([("x", Int); ("y", Int)], Var("x")), []);
  ( Rec("rec_f", Int, Fn ([("n" , Int); ("b", Bool)], 
                          If(
                            Primop(Equals, [Var "b"; B true]),
                            Var "n",
                            Apply(Var "rec_f", [Primop(Minus, [Var "n"; I 1]); Var "c"])))),
    ["c"]);
  ( Apply (Fn([("x", Int); ("y", Int)], Primop(Plus, [Var "x"; Var "y"])), 
           [Var "a"; Var "b"]), ["a"; "b"])
  
        
  
]

(* TODO: Implement the missing cases of free_variables. *)
let rec free_variables : exp -> name list =
  (* Taking unions of lists.
     If the lists are in fact sets (all elements are unique),
     then the result will also be a set.
  *)
  let union l1 l2 = delete l2 l1 @ l2 in
  let union_fvs es =
    List.fold_left (fun acc exp -> union acc (free_variables exp)) [] es
  in
  function
  | Var y -> [y]
  | I _ | B _ -> []
  | If(e, e1, e2) -> union_fvs [e; e1; e2]
  | Primop (_, args) -> union_fvs args
  | Fn (xs, e) ->
      let rec remove_tp = (fun l -> match l with
          | (var, tp) :: rest -> var:: (remove_tp rest)
          | _ -> []
        ) 
      in 
      delete (remove_tp xs) (free_variables e)
        
  | Rec (x, _, e) ->
      
      delete ([x]) (free_variables e)
        
  | Let (x, e1, e2) ->
      delete [x] (union (free_variables e1) (free_variables e2))
        
  | Apply (e, es) -> 
      union
        (match es with
         | e::es2 -> union (free_variables e) (free_variables (Apply (e,es2)))
         | _ -> [])
        (free_variables e)
        
      


(* TODO: Write a good set of tests for unused_vars. *)
let unused_vars_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (Let ("x", I 1, I 5), ["x"]);
  (Fn ([("x", Int); ("y", Bool)], Var "y"), ["x"]);
  (Rec ("rec", 
        Int,
        Fn([("x", Int); ("y", Int)], Apply(Var "rec", [Var "x"; I 1]))
       ), ["y"]);
  (Rec ("rec", 
        Int,
        Fn([("x", Int); ("y", Int)], Apply(Fn([("q", Int); ("r", Int)], Primop(Plus, [Var "q"; Var "r"])), [Var "x"; I 1]))
       ), ["y"; "rec"]);
  
  (Apply (Fn([("a", Int); ("b", Int)], Primop(Plus, [Var "a"; I 1])), [I 1; I 1]), 
   ["b"] )
  
  
]

(* TODO: Implement the missing cases of unused_vars. *)
let rec unused_vars =
  function
  | Var _ | I _ | B _ -> []
  | If (e, e1, e2) -> unused_vars e @ unused_vars e1 @ unused_vars e2
  | Primop (_, args) ->
      List.fold_left (fun acc exp -> acc @ unused_vars exp) [] args
  | Let (x, e1, e2) ->
      let unused = unused_vars e1 @ unused_vars e2 in
      if List.mem x (free_variables e2) then
        unused
      else
        x :: unused

  | Rec (x, _, e) -> 
     
      let unused = unused_vars e in
  
      if List.mem x (free_variables e) then unused 
      else 
        (match e with
         | Let(a, b, c) when x = a -> 
             if List.mem x (free_variables b) then unused 
             else x::unused
         | _ -> x::unused) 
  
          

  | Fn (xs, e) -> 
      let rec remove_tp = fun l -> match l with
        | (var, _) :: rest -> var:: (remove_tp rest)
        | _ -> []
               
      in
      let rec pick_unused = fun l ->
        match l with
        | v::vs -> 
            if List.mem v (free_variables e) then pick_unused vs
            else v::(pick_unused vs)
        | _ -> []
      in
      (pick_unused (remove_tp xs)) @ (unused_vars e)
          
      

  | Apply (e, es) -> 
      let rec iterate = fun l -> match l with
        | e::es -> (unused_vars e) @ (iterate es)
        | _ -> []
      in
      (unused_vars e)@(iterate es)

(* TODO: Write a good set of tests for subst. *)
(* Note: we've added a type annotation here so that the compiler can help
   you write tests of the correct form. *)
let subst_tests : (((exp * name) * exp) * exp) list = [
  (* An example test case. If you have trouble writing test cases of the
     proper form, you can try copying this one and modifying it.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (((I 1, "x"), (* [1/x] *)
    (* let y = 2 in y + x *)
    Let ("y", I 2, Primop (Plus, [Var "y"; Var "x"]))),
   (* let y = 2 in y + 1 *)
   Let ("y", I 2, Primop (Plus, [Var "y"; I 1])));
   
  
  (((Var "y", "x") , 
    Fn([("x", Int); ("y", Int)], Primop(Times, [Var "x"; Var "y"])) ) , 
   Fn([("x", Int); ("y", Int)], Primop(Times, [Var "x"; Var "y"])));
  
  (((Primop(Plus,[Var "x"; I 1]), "x") , 
    Fn([("y", Int)], Primop(Times, [Var "x"; Var "y"])) ) , 
   Fn([("y", Int)], Primop(Times, [Primop(Plus,[Var "x"; I 1]); Var "y"])));
  
  (((Primop(Plus, [Var "x"; I 1]), "a"),
    Fn([("x", Int)], Primop(Plus, [Var "x"; Var "a"]))),
   Fn([("z", Int)], Primop(Plus, [Var "z"; Primop(Plus, [Var "x"; I 1])])));
  
  
  (((Primop(Plus, [Var "x"; I 1]), "a"),
    Apply(Fn(["x", Int], Primop(Plus, [Var "x"; Var "a"])), [I 1; I 2])),
   Apply(Fn(["z", Int], Primop(Plus, [Var "z"; Primop(Plus, [Var "x"; I 1])])), [I 1; I 2]));
  
  (((I 1, "a"),
    Apply(Fn(["x", Int], Primop(Plus, [Var "x"; I 1])), [Var "x"; Var "a"])),
   Apply(Fn(["x", Int], Primop(Plus, [Var "x"; I 1])), [Var "x"; I 1]));
  
  
  (((Var "inf", "a"),
    Rec ("inf", Int, Fn(["x", Int], Apply(Var "inf", [Apply(Var "a", [Var "x"])])))),
   Rec ("inff", Int, Fn(["x", Int], Apply(Var "inff", [Apply(Var "inf", [Var "x"])]))));
  
  (((Var "x", "inf"),
    Rec ("inf", Int, Fn(["x", Int], Apply(Var "inf", [Var "x"])))),
   Rec ("inf", Int, Fn(["x", Int], Apply(Var "inf", [Var "x"]))))
]

(* TODO: Implement the missing cases of subst. *)
let rec subst ((e', x) as s) exp =
  match exp with
  | Var y ->
      if x = y then e'
      else Var y
  | I n -> I n
  | B b -> B b
  | Primop (po, args) -> Primop (po, List.map (subst s) args)
  | If (e, e1, e2) ->
      If (subst s e, subst s e1, subst s e2)
  | Let (y, e1, e2) ->
      let e1' = subst s e1 in
      if y = x then
        Let (y, e1', e2)
      else
        let (y, e2) =
          if List.mem y (free_variables e') then
            rename y e2
          else
            (y, e2)
        in
        Let (y, e1', subst s e2)

  | Rec (y, t, e) -> 
      
      if y=x then exp
      else if (List.mem y (free_variables e')) then
        let y', exp' = rename y e in
        Rec (y', t, subst s exp')
      else
        Rec(y, t, subst s e)

  | Fn (xs, e) -> 
      
      let rec combine = fun l1 l2 -> 
        match l1 with
        |x::xs ->
            (match l2 with
             | y::ys -> (x,y)::combine xs ys
             | _ -> [])
        |_ -> [] 
      in
                    
      
      let free_e' = free_variables e' in
      let xs_names = List.map (fun(a,b) -> a) xs in
      let captured = List.filter (fun(a,_)-> List.mem a free_e') xs in
      let types =  List.map (fun(_,b)->b) captured in
      let captured_names = List.map (fun(a,_)->a) captured in
      
      
      (*Case 1: x occurs in xs*) 
      if (List.mem (x : name) (xs_names : name list))
      then exp 
          (*
      (*Case 2: var in xs occurs in e'*)
      else if not (captured = []) 
      then
        let captured_names', e' = rename_all captured_names e in
        let xs' = combine captured_names' types in
        Fn(xs', subst s e')
  
          *)
      
      (*Case base*)
      else
        Fn (xs, subst s e)
          
  | Apply (e, es) -> 
      
      Apply ((subst s e), (List.map (subst s) es))

and rename x e =
  let x' = freshVar x in
  (x', subst (Var x', x) e)

and rename_all (names : name list) (exp : exp) : (name list *exp) =
  List.fold_right
    (fun name (names, exp) ->
       let (name', exp') = rename name exp in
       (name' :: names, exp'))
    names
    ([], exp)

(* Applying a list of substitutions to an expression, leftmost first *)
let subst_list subs exp =
  List.fold_left (fun exp sub -> subst sub exp) exp subs
