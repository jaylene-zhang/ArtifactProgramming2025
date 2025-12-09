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
       | Let (y, Primop _, Var z) ->
           if y = x && z = x then [] 
           else
             let unused = unused_vars e in
             if List.mem x (free_variables e) then unused else x :: unused
       | Fn (xs, body) ->
           let free = free_variables body in
           union (unused_vars body)
             (List.fold_left (fun acc (x, _) ->
               if List.mem x free then acc else x :: acc) [] xs)
       | Apply (func, args) ->
           union (unused_vars func)
             (List.fold_left (fun acc exp ->
               union acc (unused_vars exp)) [] args)
       | _ ->
           let unused = unused_vars e in
           if List.mem x (free_variables e) then unused else x :: unused)
  | Fn (xs, e) ->
      let free = free_variables e in
      union (unused_vars e)
        (List.fold_left (fun acc (x, _) ->
          if List.mem x free then acc else x :: acc) [] xs)
  | Apply (e, es) ->
      union (unused_vars e)
        (List.fold_left (fun acc exp ->
          union acc (unused_vars exp)) [] es)