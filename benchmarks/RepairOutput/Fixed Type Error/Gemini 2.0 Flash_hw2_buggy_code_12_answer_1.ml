```ocaml
(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = [ 
  (Const(3.0), Const(0.0));
  (Var, Const(1.0));
  ((Pow(Var, 2)), Times(Times(Const(2.0), Pow(Var, 1)), Const(1.0)))
  
]
```