The issue is in the `Fn` case of the `subst` function. There's a type mismatch in how rename_all is used and the handling of function parameters. Here's the fixed code:

```ocaml
  | Fn (xs, e) -> 
      if List.mem x (List.map fst xs) then Fn (xs, e)
      else 
        let (xs, e) =
          if List.exists (fun f -> List.mem f (free_variables e')) (List.map fst xs) then
            let new_names, new_e = rename_all (List.map fst xs) e in
            (List.map2 (fun name tp_val -> (name, tp_val)) new_names (List.map snd xs), new_e)
          else (xs, e)
        in 
        Fn (xs, subst s e)
```