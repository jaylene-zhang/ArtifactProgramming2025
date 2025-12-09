```ocaml
(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
    (* Your test cases go here *)
    (((1, 2), (1, 2)), 0);
    (((-1, 2), (-1, 2)), 0);
]

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) = 
  if y2 > y1 then 
    if x2 > x1 then
      (y2 - y1) + (x2 - x1)
    else
      (y2 - y1) + (x1 - x2) 
  else 
    (y1 - y2) + (if x2 > x1 then x2 - x1 else x1 - x2)


(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
let binomial_tests = [
  (* Your test cases go here. Correct the incorrect test cases for the function. *)
  ((0, 0), 1);
]

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let rec fact n =
  if n = 0 then 1
  else n * fact (n - 1)

let binomial n k =
  fact n / (fact k * fact (n - k))


(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
let lucas_tests = [
    (0, 2);
    (1, 1);
    (2, 3);
    (3, 4);
    (4, 7);
]

(* TODO: Implement a tail-recursive helper lucas_helper. *)
let rec lucas_helper n curr prev =
  if n = 0 then curr
  else lucas_helper (n - 1) (curr + prev) curr

(* TODO: Implement lucas that calls the previous function. *)
let lucas n =
  if n = 0 then 2
  else if n = 1 then 1
  else lucas_helper (n - 1) 1 2
```