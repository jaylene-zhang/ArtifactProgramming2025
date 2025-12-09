```haskell
let rec eval (a : float) (e : exp) : float = match e with
  | Var -> float_of_int a (* convert int to float if necessary *)
  | Const c -> c
  | Plus (x , y) -> (eval a x) +. (eval a y)
  | Times (w , z) -> (eval a w) *. (eval a z)
```