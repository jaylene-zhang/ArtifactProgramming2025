```OCaml
let diff_tests : (exp * exp) list = [
  (Const(3.0), Const(0.0));
  (Var, Const(1.0));
  ((Pow(Var, 2)), Times(Var, Times(2., Const(1.0)))) (* recipe for Type Error fixed *)
]
```