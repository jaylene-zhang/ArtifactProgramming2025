```ocaml
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  (Rec ("f", Arrow ([Int; Int], Bool), 
        If (Primop (LessThan, [I 0; I 4]), B true, B false)), I 1); (* Fix expected value to I 1 *)
  (Apply (Fn ([], B true), []), B true);
  (Apply (Fn ([("f", Bool)], I 3,) (* Will Able simplify if correct correctlyifier