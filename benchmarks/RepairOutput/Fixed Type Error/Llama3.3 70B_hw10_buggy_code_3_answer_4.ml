```ocaml
(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Let ("x", Primop (Plus, [Var "x"; I 5]), Var "x")), I 6);
  (Rec ("f", Arrow ([Int;Int], Bool), 
        If(Primop(LessThan, [Var "f"; I 4]), B true, B false)), B true);
  (Apply (Fn ([], B true), []), B true);
  (Apply (Fn ([("f", Bool)], B true), Var "f"), B true)
]
```