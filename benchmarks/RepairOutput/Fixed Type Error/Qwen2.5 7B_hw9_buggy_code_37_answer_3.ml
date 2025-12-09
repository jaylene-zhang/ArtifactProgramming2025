```ocaml
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
      if y = x then Rec (y, t, e)
      else 
        let (y, e) = 
          if List.mem y (free_variables e') then rename y e 
          else (y, e) 
        in 
        Rec (y, t, subst s e)
  | Fn (xs, e) -> 
      if List.mem x (List.map fst xs) then 
        let new_xs = List.map (fun (y, t) -> (renameVar y, t)) xs in
        let (new_xs, e') = renameAll new_xs e in
        Fn (new_xs, subst s e')
      else
        let (new_xs, e) =
          if List.exists (fun (y, t) -> List.mem y (free_variables e')) (List.map fst xs) then
            ((List.map2 (fun (y, t) (y', t') -> (y', t)) xs (List.map (fun _ -> x) xs)), e')
          else (xs, (renameAll xs e))
        in 
        Fn (new_xs, subst s e)
  | Apply (e, es) -> 
      let app = List.map (subst s) es in 
      Apply (subst s e, app)

and renameVar x = freshVar x

and renameAll varNames exp =
  let renameHelper varNames exp =
    match varNames with
    | [] -> (exp, [])
    | var :: rest ->
        let (var', exp') = rename var exp in
        let (exp'', rest') = renameHelper rest exp' in
        (exp'', var' :: rest')
  in
  renameHelper varNames exp
```