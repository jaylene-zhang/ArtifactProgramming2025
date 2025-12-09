
    (**To DO: Write a good set of tests for free_variables **)
let free_variables_tests : (exp * name list) list = [
  (* An example test case.
     Note that you are *only* required to write tests for Let, Rec, Fn, and Apply!
  *)
  
  (ex1,[]);(ex3,[]);(Apply (Var "f", [I 3; I 4]),["f"]);
  (Rec ("x",Int,Primop (Plus, [Var "x";I 1])),[])
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
      let x = List.map (fun (y,_)-> y) xs
      in
      delete x (union_fvs [e])
  | Rec (x, _, e) -> delete [x] (union_fvs [e]) 
  | Let (x, e1, e2) ->
      delete [x] (union_fvs [e1;e2])
  | Apply (e, es) -> union_fvs (e::es)


(* TODO: Write a good set of tests for unused_vars. *)
let unused_vars_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (Rec ("x",Int,Primop (Plus, [Var "y";I 1])),["x"]);
  (ex1,[]);
  (Apply (Var "f", [I 3; I 4]),[]);
  (Rec ("x",Int,Primop (Plus, [Var "x";I 1])),[]);
  (Fn ([("x",Int)],I 5),["x"])
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
      (match e with
       | Let(e,e1,e2)->
           let unused = unused_vars (Let(e,e1,e2)) in
           if List.mem x (free_variables e1) || 
              (List.mem x (free_variables e2) && e <> x)
           then
             unused
           else
             x :: unused
       | _ -> 
           let unused = unused_vars e in
           if List.mem x (free_variables e) then
             unused
           else
             x :: unused
      )
  
  | Fn (xs, e) -> 
      let x = List.map (fun (y,_)-> y) xs
      in unused_vars e @ delete (free_variables e) x
           
  | Apply (e, es) -> 
      let x=List.fold_left (fun acc exp -> acc @ unused_vars exp) [] (e::es)
      in x
        
        
      

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
  
   
  (((I 1, "s"), 
    (Rec ("s", Bool, Var "s"))), 
   (Rec ("s", Bool, Var "s")));
  
  (((I 1, "x"), 
    Rec ("f", Int, Var "x")), 
   (Rec ("f", Int, I 1)));
  
  
  (((I 1, "a"), 
    (Apply (Var "a", [B false; B false]))), 
   (Apply (I 1, [B false; B false])));
  
  
  (((I 1, "a"), 
    (Apply (Var "a", [Var "a"; Let("a",I 2,Var "a")]))), 
   (Apply (I 1, [I 1;  Let("a",I 2,Var "a")])));
  
  (((I 1, "x"), 
    Fn ([("x", Int)],Primop (Times, [Var "x"; Var "x"]))), 
   Fn ([("x", Int)],Primop (Times, [Var "x"; Var "x"])));
  
  (((I 1, "y"), 
    Fn ([("x", Int)],Primop (Times, [Var "x"; Var "y"]))), 
   Fn ([("x", Int)],Primop (Times, [Var "x"; I 1])));
  
  
  
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
          
  | Fn (xs, e) ->
      let a = List.map (fun (y,_)-> y) xs 
      in
      Fn (xs, e)
  | Rec (y, t, e) -> 
      if y = x then
        Rec(y,t,e)
      else let (y, e) =
             if List.mem y (free_variables e') then rename y e
             else
               (y,e)
        in Rec(y,t,subst s e)

  | Apply (e, es) -> Apply (subst s e,(List.map (fun e->subst s e) es))

and rename x e =
  let x' = freshVar x in
  (x', subst (Var x', x) e)

and rename_all names exp =
  List.fold_right
    (fun name (names, exp) ->
       let (name', exp') = rename name exp in
       (name' :: names, exp'))
    names
    ([], exp)

(* Applying a list of substitutions to an expression, leftmost first *)
let subst_list subs exp =
  List.fold_left (fun exp sub -> subst sub exp) exp subs
