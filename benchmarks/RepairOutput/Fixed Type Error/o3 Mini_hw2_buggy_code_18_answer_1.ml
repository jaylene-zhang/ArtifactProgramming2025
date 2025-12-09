type nat = Z | S of nat
type exp =
  | Const of float
  | Var
  | Plus of exp * exp
  | Times of exp * exp
  | Pow of exp * int

let rec eval (a : float) (e : exp) : float =
  match e with
  | Var -> a
  | Const c -> c
  | Plus (x, y) -> (eval a x) +. (eval a y)
  | Times (w, z) -> (eval a w) *. (eval a z)
  | Pow (b, n) ->
      let rec power x n =
        if n = 0 then 1.0 else x *. power x (n - 1)
      in
      power (eval a b) n