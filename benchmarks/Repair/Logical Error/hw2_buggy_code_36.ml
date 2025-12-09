(* Question 1 *)

(* TODO: Write a good set of tests for {!q1a_nat_of_int}. *)
let q1a_nat_of_int_tests : (int * nat) list = [
  (1, S Z); 
]

(* TODO:  Implement {!q1a_nat_of_int} using a tail-recursive helper. *)
let rec q1a_nat_of_int (n : int) : nat = 
  let rec q1a_tail (k: int) acc =
    if k < 0 then raise Invalid_test_case else
      match k with
      |0 -> acc
      |k -> q1a_tail (k-1) (S acc) 
  in 
  q1a_tail n Z

(* TODO: Write a good set of tests for {!q1b_int_of_nat}. *)
let q1b_int_of_nat_tests : (nat * int) list = [
  (Z, 0)
]

(* TODO:  Implement {!q1b_int_of_nat} using a tail-recursive helper. *)
let rec q1b_int_of_nat (n : nat) : int = 
  let rec q1b_tail (k: nat) acc =
    match k with
    |Z -> acc
    |S k -> q1b_tail k (acc+1)
  in
  q1b_tail n 0

(* TODO: Write a good set of tests for {!q1c_add}. *)
let q1c_add_tests : ((nat * nat) * nat) list = [
  ((Z, Z), Z); 
  ((S Z, Z), S Z); 
]

(* TODO: Implement {!q1c_add}. *)
let rec q1c_add (n : nat) (m : nat) : nat = 
  match (n, m) with
  | (Z, Z) -> Z
  | (Z, S m) -> S m
  | (S n, Z) -> S n
  | (S n, S m) -> S (S (q1c_add n m))


(* Question 2 *)

(* TODO: Implement {!q2a_neg}. *)
let q2a_neg (e : exp) : exp = 
  Times (Const (-1.0), e)
(* TODO: Implement {!q2b_minus}. *)
let q2b_minus (e1 : exp) (e2 : exp) : exp = 
  Plus (e1, q2a_neg e2)

(* TODO: Implement {!q2c_quot}. *)
let q2c_quot (e1 : exp) (e2 : exp) : exp = 
  Times (e1, Pow (e2, -1))


(* Question 3 *)

(* TODO: Write a good set of tests for {!eval}. *)
let eval_tests : ((float * exp) * float) list = [
  ((1.0, Plus (Var, Var)), 2.0); 
  ((2.0, Times (Var, Var)), 4.0); 
  ((2.0, Pow (Var, 2)), 4.0); 
  ((2.0, Times (Const 2.0, Const 2.0)), 4.0); 
]

(* TODO: Implement {!eval}. *)
let rec eval (a : float) (e : exp) : float = 
  match e with
  |Var -> a
  |Plus (e1, e2) -> (eval a e1) +. (eval a e2)
  |Times (e1, e2) -> (eval a e1) *. (eval a e2)
  |Pow (e1, power) -> ( ** ) (eval a e1) (float_of_int power)


(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = []

(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp = raise Not_implemented
