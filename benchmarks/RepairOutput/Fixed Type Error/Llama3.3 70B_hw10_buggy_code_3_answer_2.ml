```ocaml
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, 
        Let ("y", I 5, 
             Primop (Plus, [Var "x"; Var "y"]))), 
   I 6);
  (Rec ("f", Arrow ([Int], Bool), 
        If(Primop(LessThan, [Var "x"; I 4]), B true, B false)),
   Let ("x", I 0, Apply (Var "f", [Var "x"])));
  (Apply (Fn ([], B true), []), B true);
  (Apply (Fn ([("f", Bool)], 
              If (Var "f", B true, B false)), [B true]), 
   B true)
]
```