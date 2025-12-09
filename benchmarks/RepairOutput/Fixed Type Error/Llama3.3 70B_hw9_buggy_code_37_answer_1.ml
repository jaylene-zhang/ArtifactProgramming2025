```ocaml
| Fn (xs, e) -> 
    if List.mem x (List.map fst xs) then Fn (xs,e)
    else 
      let xs' = List.map (fun (f, tp) -> 
          if List.mem f (free_variables e') then (freshVar f, tp) else (f, tp)) xs in
      Fn (xs', subst s e)
```