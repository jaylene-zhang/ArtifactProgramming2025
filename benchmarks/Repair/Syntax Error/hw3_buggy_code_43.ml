(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
  ((9, 3), (5, 10), 3);
  ((3, 4), (5, 7), 5);
  ((7, 1), (6, 4), 4);
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) : int = 
  (*match (x1, y1) with
   | (a, b) -> match (x2, y2) with
     | (c, d) -> if a - c *)
  let xPos : (x1 - x2)
           


(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
    (*let binomial_tests = [
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
*);;