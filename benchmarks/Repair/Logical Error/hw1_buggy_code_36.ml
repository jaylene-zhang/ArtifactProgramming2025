(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
    (* Your test cases go here *)
  (((1,1),(1,1)),(0));
  (((12,12),(9,9)),(6));
  (((9,9),(12,12)),(6));
  (((-12,12),(9,-9)),(42));
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) =
  abs(x2-x1) + abs(y2-y1)
  
  



(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
let binomial_tests = [
  (* Your test cases go here. Correct the incorrect test cases for the function. *)
  ((1, 1), 1);
  ((12, 1), 12);
  ((12, 2), 66);
  ((3, 12), 0);



]

let rec factorial n = 
  if n <= 1 then 1 
  else 
    factorial (n-1) * n;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*) 
exception InvalidParameters
let binomial n k =
  if n < 0 || k < 0 || k > n then raise InvalidParameters
  else
    (factorial n) / ((factorial k) * (factorial (n-k)))



      (*(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
        let lucas_tests = [
        ]

(* TODO: Implement a tail-recursive helper lucas_helper. *)
        let rec lucas_helper params =
          raise NotImplemented


(* TODO: Implement lucas that calls the previous function. *)
        let lucas n =
          raise NotImplemented*)
