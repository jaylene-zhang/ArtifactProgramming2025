(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
    (* Your test cases go here *)
  (* a a =0 *)
  (((0, 0), (0, 0)), 0) ; 
  
  (*  a b = b a *)
  
  (((5, 3), (3, 6)), 5);
  (((3, 6),(5, 3)), 5); 
  
  
  
  (* a b => 0 *)
  (((1, 1), (0, 0)), 2) ; 
  
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) = 
  abs (y2-y1) + abs (x2-x1) 



(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
let binomial_tests = [
  (* Your test cases go here. Correct the incorrect test cases for the function. *)
  
  ((0, 0), 1);
  ((5, 3), 10); 
  

]

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let binomial n k =
  let rec factorial number =
    if number = 0 then 1 else number* (factorial (number-1) )
  in 
  (factorial n ) / ((factorial k) * (factorial (n- k)))
  



(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
let lucas_tests = [
  (0, 2);
  (1,1);
  (2,3);
  
]

(* TODO: Implement a tail-recursive helper lucas_helper. *)
let rec lucas_helper nb goingn  goingnminus1 goingnminus2 =
  if goingn > nb then goingnminus1 else 
    lucas_helper nb (goingn+1) (goingnminus1+goingnminus2) goingnminus1 
    


(* TODO: Implement lucas that calls the previous function. *)
let lucas n = 
  if n=0 then 2 else 
  if n=1 then 1 else 
      
    lucas_helper n 2 1 2 ;
    
  
