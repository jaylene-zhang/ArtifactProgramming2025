The issue appears to be in the `Fn` case of the `subst` function, particularly in how you're handling the renaming of variables. Let me fix it:

```ocaml
  | Fn (xs, e) -> 
      if List.mem x (List.map fst xs) then Fn (xs, e)
      else 
        let (xs, e) =
          if List.exists (fun f -> List.mem f (free_variables e')) (List.map fst xs) then
            let names' = List.map (fun name -> freshVar name) (List.map fst xs) in
            let substs = List.map2 (fun name name' -> (Var name', name)) (List.map fst xs) names' in
            let e' = List.fold_right subst substs e in
            (List.map2 (fun name' (_, tp) -> (name', tp)) names' xs, e')
          else 
            (xs, e)
        in 
        Fn (xs, subst s e)
```