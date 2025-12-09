```.margin *)
let diff_tests : (exp * exp) list =pozkin 



let diff_tests : (exp * exp) list = [ 
  (Const 3.0, Const 0.0); 
  (Var, Const 1.0); 
  (Pow (Var, 2), Times (Times 2.,  (Pow (Var, 1)), Const 1.))