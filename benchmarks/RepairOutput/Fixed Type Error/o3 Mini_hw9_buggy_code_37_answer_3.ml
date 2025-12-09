let rec subst ((sub_e, x) as s) exp =
  match exp with
  | Var y ->
      if x = y then sub_e else Var y
  | I n -> I n
  | B b -> B b
  | Primop (op, args) ->
      Primop (op, List.map (subst s) args)
  | If (e, e1, e2) ->
      If (subst s e, subst s e1, subst s e2)
  | Let (y, e1, e2) ->
      let e1' = subst s e1 in
      if y = x then Let (y, e1', e2)
      else
        let (y, e2') =
          if List.mem y (free_variables sub_e) then rename y e2
          else (y, e2)
        in
        Let (y, e1', subst s e2')
  | Rec (y, t, e) ->
      if y = x then Rec (y, t, e)
      else
        let (y, e') =
          if List.mem y (free_variables sub_e) then rename y e
          else (y, e)
        in
        Rec (y, t, subst s e')
  | Fn (xs, e) ->
      if List.mem x (List.map fst xs) then Fn (xs, e)
      else
        let (new_names, new_e) =
          if List.exists (fun n -> List.mem n (free_variables sub_e)) (List.map fst xs) then
            rename_all (List.map fst xs) e
          else
            (List.map fst xs, e)
        in
        let new_xs = List.map2 (fun new_n (_, t) -> (new_n, t)) new_names xs in
        Fn (new_xs, subst s new_e)
  | Apply (e, es) ->
      Apply (subst s e, List.map (subst s) es)

and rename x e =
  let x' = freshVar x in
  (x', subst (Var x', x) e)

and rename_all names exp =
  List.fold_right
    (fun name (names_acc, exp_acc) ->
       let (name', exp') = rename name exp_acc in
       (name' :: names_acc, exp'))
    names
    ([], exp)