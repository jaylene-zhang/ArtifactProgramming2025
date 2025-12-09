(*4*)
(Let("g", Rec("f", Arrow([Int],Int),Fn([("x",Int)],If(Primop(Equals,[Var "x"; I 0]),Var "x",Primop(Plus,[Var "x"; Apply("f",[Primop(Minus,[Var "x"; I 1])])])))),Apply("f", [I 3])),I 6); 

(*6*)(Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7);