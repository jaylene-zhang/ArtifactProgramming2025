```haskell
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
            (y, rename y e2)
          else
            (y, e2)
        in
        Let (y, e1', subst s e2)
and rename x e =
  let x' = freshVar x in
  (x', subst (Var x', x) e)
and rename_all names exp =
  let rec subst_list lst =
    match lst with
    | [] -> exp
    | var::tl ->
        let (var', exp') = rename var exp in
        subst_list tl exp'
  in
  List.fold_right
    (fun name (names, exp) ->
       let (name', exp') = rename name exp in
       (name' :: names, exp'))
    names
    ([], subst_list (List.map fst xs))
  in
  Fn (rename_all (List.map fst xs) e)
```