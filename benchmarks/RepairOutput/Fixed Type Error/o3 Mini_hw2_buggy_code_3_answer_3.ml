type exp =
  | Const of float
  | Var
  | Plus of exp * exp
  | Times of exp * exp
  | Pow of exp * int

let rec diff (e : exp) : exp =
  match e with
  | Plus (l, r) -> Plus (diff l, diff r)
  | Times (l, r) -> Plus (Times (diff l, r), Times (diff r, l))
  | Pow (l, r) -> Times (Const (float_of_int r), Times (Pow (l, r - 1), diff l))
  | Var -> Const 1.0
  | Const _ -> Const 0.0