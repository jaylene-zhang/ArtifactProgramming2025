```haskell
| Rec (x, _, e) -> match e with
    | Let (y, _, Var z) -> if y = x && z = x then []
    | _ -> let unused = unused_vars e in
        if List.mem x (free_variables e) then 
          unused 
        else 
          x :: unused 
```