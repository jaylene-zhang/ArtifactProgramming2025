(* Question 1: Manhattan Distance *)
(* TODO: Write a good set of tests for distance. *)
let distance_tests = [((3,9),(1,2)),9
    (* Your test cases go here *)
                     ]
;;

(* TODO: Correct this implementation so that it compiles and returns
         the correct answers.
*)
let distance (x1, y1) (x2, y2) = 
  (y2-y1) + (x2- x1) 



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
    
    

(* Question 1: Manhattan Distance *) 

let distance (x1, y1) (x2, y2) = 
  let y = abs(y2-y1) in
  let x = abs(x2- x1) in
  y + x 


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
           
  n choose k: (n!)/k!(n-k)!
*)
let binomial n k =
  let factorial (x : int) : int = 
    let rec go x partial_product = 
      if x = 0 then partial_product else go (x-1) (partial_product * x)
    in go x 1
  in 
  (factorial n)/((factorial k)*(factorial(n-k)))
                   (* raise NotImplemented *) 

(* Question 3: Lucas Numbers *)

(* TODO: Write a good set of tests for lucas_tests. *)
let lucas_tests = [
]

(* TODO: Implement a tail-recursive helper lucas_helper. *)
let rec lucas_helper (n:int) (i:int) (a:int) (b:int) : int =
  if i = n then a else
    lucas_helper n (i+1) b (a+b) 
      (*     raise NotImplemented*)


(* TODO: Implement lucas that calls the previous function. *)
let lucas n : int= 
  lucas_helper n 0 2 1
    (*raise NotImplemented*)
    
    




