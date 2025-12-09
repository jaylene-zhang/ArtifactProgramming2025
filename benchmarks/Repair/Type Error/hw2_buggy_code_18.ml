
let rec eval (a : float) (e : exp) : float = match e with
  | Var -> a
  | Const c -> c
  | Plus (x , y) -> (eval a x) +. (eval a y)
  | Times (w , z) -> ( * ) (eval a w) (eval a z)
