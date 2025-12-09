```ocaml
(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec and Apply!
  *)
  (Let ("x", I 1, Primop (Plus, [Var "x"; I 5])), I 6);
  (Apply(Fn([], I 2), []), I 2);
  (Rec ("f", Int, Fn([], I 3)), Fn([], I 3));
  (Apply(Rec("a", Bool, Fn(["b", Bool], B true)), [B true]), B true);
  (Apply(Fn([("a", Int); ("b", Int)], Primop(Minus, [Var "a"; Var "b"])), [I 2; I 1]), I 1)
]

(* TODO: Write a good set of tests for infer. *)
let infer_tests = [
  (* An example test case.
     Note that you are *only* required to write tests for Rec, Fn, and Apply!
  *)
  (([("x", Int)], Var "x"), Int);
  (([("a", Bool)], Fn([], Var "a")), Arrow([], Bool));
  (([("a", Int)], Apply (Fn([], I 6), [])), Int);
  (([("a", Int)], Rec("b", Int, Fn([], Primop(Times, [Var "b"; I 0])))), Arrow([], Int));
  (([("a", Int); ("b", Int)], Fn([("a", Int); ("b", Int)], Primop(Plus, [Var "a"; Var "b"]))), Arrow([Int; Int], Int));
  (([("a", Int)], Apply(Fn([("a", Int)], Primop(Minus, [Var "a"; I 2])), [I 4])), Int);
  (([("a", Int)], Fn([("a", Int)], Primop(Equals, [Var "a"; I 2]))), Arrow([Int], Bool))
]
```