```haskell
let diff_tests : (exp * exp) list = [
  (Const(0.), Const(3.0)); (* Fix: Const(3.0) should be Const(0.) *)
  (Var, Const(1.0));
  ((Pow(Var, 2)), Times(Times(2., Pow(Var, 1)), Const(1)))
] ;;
```