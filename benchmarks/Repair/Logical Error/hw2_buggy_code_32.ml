(* Question 1 *)

(* TODO: Write a good set of tests for {!q1a_nat_of_int}. *)
let q1a_nat_of_int_tests : (int * nat) list = []

(* TODO:  Implement {!q1a_nat_of_int} using a tail-recursive helper. *)
let rec q1a_nat_of_int (n : int) : nat = 
  let rec helper num acc = 
    if num <= 0 then acc else helper (num-1) (S(acc))
  in
  helper n Z

(* TODO: Write a good set of tests for {!q1b_int_of_nat}. *)
let q1b_int_of_nat_tests : (nat * int) list = []

(* TODO:  Implement {!q1b_int_of_nat} using a tail-recursive helper. *)
let rec q1b_int_of_nat (n : nat) : int =
  let rec helper n acc =
    match n with 
    | S(n) -> helper n (acc+1)
    | Z -> acc
  in
  helper n 0

(* TODO: Write a good set of tests for {!q1c_add}. *)
let q1c_add_tests : ((nat * nat) * nat) list = []

(* TODO: Implement {!q1c_add}. *)
let rec q1c_add (n : nat) (m : nat) : nat = 
  match m with
  | S(k) -> q1c_add (S(n)) k
  | Z -> n


(* Question 2 *)

(* TODO: Implement {!q2a_neg}. *)
let q2a_neg (e : exp) : exp = 
  Times (Const(-1.0), e)

(* TODO: Implement {!q2b_minus}. *)
let q2b_minus (e1 : exp) (e2 : exp) : exp = 
  Plus (e1, q2a_neg(e2))

(* TODO: Implement {!q2c_quot}. *)
let q2c_quot (e1 : exp) (e2 : exp) : exp = 
  Times(e1, Pow(e2, -1))


(* Question 3 *)

(* TODO: Write a good set of tests for {!eval}. *)
let eval_tests : ((float * exp) * float) list = []

(* TODO: Implement {!eval}. *)
let rec eval (a : float) (e : exp) : float = 
  match e with
  | Const(x) -> x
  | Var -> a
  | Plus(x, y) -> (eval a x) +. (eval a y)
  | Times(x, y) -> (eval a x) *. (eval a y)
  | Pow(e, n) -> (eval a e) ** (float_of_int n)


(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = []

(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp = 
  match e with
  | Const(_) -> Const(0.0)
  | Var -> Const(1.0)
  | Plus(a, b) -> Plus(diff(a), diff(b))
  | Times(a, b) -> Plus(Times(diff a, b), Times(a, diff b))
  | Pow(e, n) -> Times(Times(Const(float_of_int n), Pow(e, n-1)), diff e)
                   
  
  
  
  