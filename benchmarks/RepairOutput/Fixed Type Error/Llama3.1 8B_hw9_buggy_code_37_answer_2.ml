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
            rename y e2
          else
            (y, e2)
        in
        Let (y, e1', subst s e2)

  | Rec (y, t, e) -> (*"]), e2) -> Rec (y, t, 
      if y = x then Rec (y, t, e)
      else let (y, e) = 
             if List.mem y (free_variables e') then rename y e
             else (y, e) (*,"y", rename y e)*) 
        in Rec (y, t, subst s e)
        
  | Fn (xs, e) -> 
      if List.mem x (List.map fst xs) then 
        (** NEED TO DEEP COPY xs HERE, 
         * e.g., let xs2 = List.map (fun _, v -> v) xs and Restore xs xs2
         *)
          Fn (xs, e)
      else 
        let (xs, e) =
          if List.exists (fun f -> List.mem f (free_variables e')) (List.map fst xs) then
            ((List.map2 (fun f (_,tail) -> (f, tail)) (List.map fst xs)), e')
          else (xs, (rename_all (List.map fst xs) e))
        in 
        Fn (xs, subst s e)
            
  | Apply (e, es) -> 
      let app = List.map2 (fun e e_s -> subst s e_s) es (List.map (subst s) es) in (** NEED TO DEEP COPY es HERE **)
      Apply (subst s e, app)
```