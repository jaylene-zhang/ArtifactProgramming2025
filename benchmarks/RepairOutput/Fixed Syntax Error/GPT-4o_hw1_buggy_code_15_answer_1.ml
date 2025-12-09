```ocaml
(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [
  (((1, 2), (3, 4)), 4); 
  (((1, 2), (4, 3)), 4); 
  (((2, 1), (3, 4)), 4); 
  (((2, 1), (4, 3)), 4)
  (* Your test cases go here *)
]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) = 
  if y1 < y2 && x1 <= x2 then (y2 - y1) + (x2 - x1) 
  else if y1 < y2 && x1 > x2 then (y2 - y1) + (x1 - x2)
  else if y1 >= y2 && x1 <= x2 then (y1 - y2) + (x2 - x1)
  else (y1 - y2) + (x1 - x2)



(* Question 2: Binomial *)
(* TODO: Write your own tests for the binomial function.
         See the provided tests for fact, above, for how to write test cases.
         Remember that we assume that  n >= k >= 0; you should not write test cases where this assumption is violated.
*)
let binomial_tests = [
  ((0, 0), 1); 
  ((3, 1), 3); 
  ((1, 1), 1); 
  ((6, 3), 20)
  (* Your test cases go here *)
]

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let binomial n k =
  let rec factorial n =
    if n = 0 then 1
    else n * (factorial (n - 1)) in 
  (factorial n) / ((factorial k) * (factorial (n - k)))
                  
                  



(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
let lucas_tests = [
]

(* TODO: Implement a tail-recursive helper lucas_helper. *)
let rec lucas_helper n l1 l2 =
  if n = 0 then l1
  else if n = 1 then l2
  else lucas_helper (n - 1) l2 (l1 + l2)


(* TODO: Implement lucas that calls the previous function. *)
let lucas n =
  lucas_helper n 2 1
```