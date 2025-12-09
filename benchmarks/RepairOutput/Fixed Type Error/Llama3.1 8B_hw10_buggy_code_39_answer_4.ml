```hpp
let eval_tests = [
  Let("g", Rec("f", Arrow([Int],Int),
          Fn([("x",Int)],
           If(Primop(Equals,[Var "x"; I 0]),Var "x",
              Primop(Plus,[Var "x"; Apply("f",[Primop(Minus,[Var "x"; I 1])])])),
             Apply("f", [I 3])))
    ,Apply("f", [I 3]));
  Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]);
  Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [I 2]);
  Let("f", Fn([("x", Int)],Primop (Plus, [Var "x"; Var "x"])),
    Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; Var "x"])), [I 3]));
];                                                                                   
```