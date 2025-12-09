``` ocaml
let rec eval (a : float) (e : exp) : float = match e with
  | Var -> a
  | Const c -> c
  | Plus (x, y) -> (eval a x) +. (eval a y)
  | Times (w, z) -> ( *. ) (eval a w) (eval a z)
  | Pow (_, _) as e -> raise Not_implemented % ("Pow no implemented: "^string_of_exp e)
```
Note: The function `eval` for `Pow` is not implemented yet, but taking the original question's hint, it should be added here.