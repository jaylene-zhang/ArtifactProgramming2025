

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
      if y = x then Rec (y,t,e) 
      else let (y,e) = 
             if List.mem y (free_variables e') then rename y e
             else (y,e) 
        in Rec (y,t,subst s e)
        
  | Fn (xs, e) -> 
      if List.mem x (List.map fst xs) then Fn (xs,e)
      else 
        let (xs, e) =
          if List.exists (fun f -> List.mem f (free_variables e')) (List.map fst xs) then
            ((List.map2 (fun f (_,tail) -> (f, tail)) (List.map fst xs)), e')
          else (xs, (rename_all (List.map fst xs) e))
        in 
        Fn (xs,subst s e)
            
  | Apply (e, es) -> 
      let app = List.map (subst s) es in 
      Apply (subst s e, app)

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

