(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
    (* Your test cases go here *)
  (((1, 2), (1,2)), 0);
  (((-1, 2), (-1,2)), 0);
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) = 
  if y2 > y1 then 
    if x2 > x1 then
      (y2 - y1) + (x2 - x1) else
      (y2 - y1) + (x1 - x2) 
  else  y2 <= y1 then
    
  (y1 - y2) + (x2 - x1)
  



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
