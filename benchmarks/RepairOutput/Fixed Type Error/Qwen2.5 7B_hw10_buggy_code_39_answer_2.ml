(* TODO: Write a good set of tests for eval. *)
let eval_tests = [
  (*1*)(Let("g", Rec("f", Arrow([Int],Int),Fn([("x",Int)],If(Primop(Equals,[Var "x"; I 0]),Var "x",Primop(Plus,[Var "x"; Apply("f",[Primop(Minus,[Var "x"; I 1])])])))),Apply("f", [I 3])),I 6);
  (*2*)(Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7); 
  (*3*)(Apply(ex1, [I 2; I 2]),I 8) ;
  (*4*)(* Add your test here *) 
  (*5*) 
  (*6*)(Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7); 
]