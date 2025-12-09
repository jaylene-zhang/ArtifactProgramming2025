```ocaml
(* Fixed Code *)
let eval_tests = [

  (*1*)(Let("g", Rec("f", Arrow([Int],Int),Fn([("x",Int)],If(Primop(Equals,[Var "x"; I 0]),Var "x",Primop(Plus,[Var "x"; Apply(Var "f",[Primop(Minus,[Var "x"; I 1])])])))),Apply(Var "f", [I 3])),I 6);
  (*2*)(Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7); 
  (*3*)(Apply(ex1, [I 2; I 2]) , I 8) ;
  (*4*)
  (*5*) 
  (*6*)(Apply(Fn([("x", Int)],Primop (Plus, [Var "x"; I 5])), [ I 2]),I 7); 
  
]
```