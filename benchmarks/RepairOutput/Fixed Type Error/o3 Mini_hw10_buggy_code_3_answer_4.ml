let eval_tests = [
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  (Rec ("f", Arrow ([Int; Int], Bool), 
        If (Primop (LessThan, [I 0; I 4]), B true, B false)), B true);
  (Apply (Fn ([], B true), []), B true);
  (Apply (Fn ([("f", Bool)], B true), [Var "f"]), B true)
]