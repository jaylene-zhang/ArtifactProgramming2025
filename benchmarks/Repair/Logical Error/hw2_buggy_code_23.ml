(* Question 1 *)

(* TODO: Write a good set of tests for {!q1a_nat_of_int}. *)
let q1a_nat_of_int_tests : (int * nat) list = [
  (0, Z);
  (5, S (S (S (S (S Z)))));  (*((5),S 11111);*)
  (2, S (S Z));
  (1, (S Z));
]

(* TODO:  Implement {!q1a_nat_of_int} using a tail-recursive helper. *)
let rec q1a_nat_of_int (n : int) : nat = raise Not_implemented(*
  let rec nat_of_int_tr n acc = 
    match n with 
    | 0 -> acc
    | _ -> 
        *)

(* TODO: Write a good set of tests for {!q1b_int_of_nat}. *)
let q1b_int_of_nat_tests : (nat * int) list = []

(* TODO:  Implement {!q1b_int_of_nat} using a tail-recursive helper. *)
let rec q1b_int_of_nat (n : nat) : int = raise Not_implemented

(* TODO: Write a good set of tests for {!q1c_add}. *)
let q1c_add_tests : ((nat * nat) * nat) list = []

(* TODO: Implement {!q1c_add}. *)
let rec q1c_add (n : nat) (m : nat) : nat = raise Not_implemented


(* Question 2 *)

(* TODO: Implement {!q2a_neg}. *)
let q2a_neg (e : exp) : exp = match e with 
  | Var -> Times (Const (-1.0), Var)
  | Const x -> Times (Const (-1.0), Const x)
  | Plus (x, y) -> Plus ((Times (Const (-1.0), x)), (Times (Const (-1.0), y)))
  | Times (a, b) -> Times (Const (-1.0), a)
  | Pow (m, n) -> Pow(m, n)
    

(* TODO: Implement {!q2b_minus}. *)
let q2b_minus (e1 : exp) (e2 : exp) : exp = raise Not_implemented

(* TODO: Implement {!q2c_quot}. *)
let q2c_quot (e1 : exp) (e2 : exp) : exp = raise Not_implemented


(* Question 3 *)

(* TODO: Write a good set of tests for {!eval}. *)
let eval_tests : ((float * exp) * float) list = [
  ((3.0, Plus (Const 2.0, Const 3.0)),5.0);
  ((1.0, (Plus (Plus (Times (Const 2.0, Pow (Var, 2)),Times (Const (-1.0), Var)), Const 10.0 ))), 11.0);
  ((0.0, (Const (0.0))), 0.0);
]

(* TODO: Implement {!eval}. *)
let rec eval (a : float) (e : exp) : float = match e with 
  | Const x -> x
  | Var -> a
  | Plus (x, y) -> (eval a x) +. (eval a y)
  | Times (x, y) -> (eval a x) *. (eval a y)
  | Pow (x, y) -> (eval a x) ** float_of_int(y)


(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = [
  (Plus (Const 2.0, Const 1.0), Const 0.0);
]

(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp = raise Not_implemented
