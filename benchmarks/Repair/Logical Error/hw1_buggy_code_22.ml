(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
    (* Your test cases go here *) 
  (((1,1),(1,1)),0);
  (((0,0),(0,0)),0);
  (((1,2),(2,1)),0);
  (((2,1),(1,2)),0);
  (((2,1),(1,1)),0);
  (((1,1),(2,1)),0);
  
  (* Insert invalid data points*)
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) = 
  let length x1 x2 y1 y2: int = (y2-y1) + (x2-x1) in
  match ((x1,y1),(x2,y2)) with
  | ((x1,y1),(x2,y2)) -> if (length x1 x2 y1 y2) >= 0 then (length x1 x2 y1 y2) 
      else ((length x1 x2 y1 y2) * -1) 
  | ((_,_),(_,_)) -> 0


(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
let binomial_tests = [
  (* Your test cases go here. Correct the incorrect test cases for the function. *)
  ((0, 0), 0);

]

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let binomial n k =
  raise NotImplemented



(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
let lucas_tests = [
]

(* TODO: Implement a tail-recursive helper lucas_helper. *)
let rec lucas_helper params =
  raise NotImplemented


(* TODO: Implement lucas that calls the previous function. *)
let lucas n =
  raise NotImplemented
