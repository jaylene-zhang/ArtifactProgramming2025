```ocaml
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  (Rec ("f", Arrow ([Int; Int], Bool), 
        Fn ([("x", Int); ("y", Int)], If(Primop(LessThan, [Var "x"; Var "y"]), B true, B false))), 
   Rec ("f", Arrow ([Int; Int], Bool), 
        Fn ([("x", Int); ("y", Int)], If(Primop(LessThan, [Var "x"; Var "y"]), B true, B false))));
  (Apply (Fn ([], B true), []), B true);
  (Apply (Fn ([("f", Bool)], Var "f"), [B true]), B true)
]
```