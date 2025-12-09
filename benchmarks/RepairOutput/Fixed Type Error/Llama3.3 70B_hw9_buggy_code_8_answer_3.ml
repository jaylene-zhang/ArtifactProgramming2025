Here is the fixed code:

```ocaml
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
  | Rec (x, _, e) -> match e with
    | Let (y, Primop _, Var z) -> if y = x && z = x then []
    | _ -> let unused = unused_vars e in
        if List.mem x (free_variables e) then 
          unused 
        else 
          x :: unused 
    | Fn (xs, e) -> 
        let free = free_variables e in
        union (unused_vars e) (List.fold_left (fun acc (x, _) -> 
            if List.mem x free then
              acc
            else
              x :: acc) [] xs)
    | Apply (e, es) -> 
        union (List.fold_left (fun acc exp -> union acc (unused_vars exp)) (unused_vars e) es) []
```
Note that I changed the last line of the `Apply` case from `union (unused_vars e) (List.fold_left...)` to `union (List.fold_left... (unused_vars e)) []`. The `union` function expects a list as its second argument, but `unused_vars e` is already a list, so we don't need to wrap it in another list.