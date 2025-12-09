```ocaml
(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
  ((9, 3), (5, 10), 11);
  ((3, 4), (5, 7), 5);
  ((7, 1), (6, 4), 4);
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) : int = 
  let x_diff = abs (x1 - x2) in
  let y_diff = abs (y1 - y2) in
  x_diff + y_diff
;;

(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
let binomial_tests = [
  (0, 0, 1);
  (5, 0, 1);
  (5, 2, 10);
  (6, 3, 20);
]
;;

(* Helper function: factorial *)
let rec factorial n =
  if n = 0 then 1
  else n * factorial (n - 1)
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
     *)
let binomial n k =
  factorial n / (factorial k * factorial (n - k))
;;

(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
let lucas_tests = [
  (0, 2);
  (1, 1);
  (2, 3);
  (3, 4);
  (4, 7);
]
;;

(* TODO: Implement a tail-recursive helper lucas_helper. *)
let rec lucas_helper n a b =
  if n = 0 then a
  else if n = 1 then b
  else lucas_helper (n - 1) b (a + b)
;;

(* TODO: Implement lucas that calls the previous function. *)
let lucas n =
  lucas_helper n 2 1
;;
```