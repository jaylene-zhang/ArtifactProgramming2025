```
let rec unused_vars =
  function
  | Var _ | I _ | B _ -> []
  | If (e, e1, e2) -> List.concat [unused_vars e; unused_vars e1; unused_vars e2]
  | Primop (_, args) ->
      List.fold_left (fun acc exp -> List.concat [acc; unused_vars exp]) [] args
  | Let (x, e1, e2) ->
      let unused = List.concat [unused_vars e1; unused_vars e2] in
      if List.mem x (free_variables e2) then
        unused
      else
        x :: unused 
  | Rec (x, _, e) -> match e with
    | Let (y, Primop _, Var z) -> if y = x && z = x then []
    | _ -> let unused = unused_vars e in
        if List.mem x (free_variables e) then 
          unused 
        else 
          x :: unused 
    | Fn (xs, e) -> 
        let free = free_variables e in
        List.fold_left (fun acc (x, _) -> 
            if List.mem x free then
              acc
            else
              x :: acc) (unused_vars e) xs
    | Apply (e, es) -> 
        let unused_e = unused_vars e in
        List.fold_left (fun acc exp -> union acc (unused_vars exp)) unused_e es
```