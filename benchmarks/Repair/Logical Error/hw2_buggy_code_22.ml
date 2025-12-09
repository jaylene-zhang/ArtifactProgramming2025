(* Question 1 *)

(* TODO: Write a good set of tests for {!q1a_nat_of_int}. *)
let q1a_nat_of_int_tests : (int * nat) list = [
  (0, Z);(3, (S (S (S Z)))); (1, (S Z))
]

(* TODO:  Implement {!q1a_nat_of_int} using a tail-recursive helper. *)
let rec q1a_nat_of_int (n : int) : nat = 
  let rec nat_cons (counter : int) (nat_repn : nat) = match (nat_repn,counter) with
    | (_,0) -> nat_repn
    | ((x),_) -> nat_cons (counter-1) ((S x))
  in 
  nat_cons n (Z)
      

(* TODO: Write a good set of tests for {!q1b_int_of_nat}. *)
let q1b_int_of_nat_tests : (nat * int) list = [
  ((S Z), 1) ; ((S (S (S Z))), 3) ; (Z,0) ;((S (S (S (S (S (S (S (S (S (S Z)))))))))),10)
]

(* TODO:  Implement {!q1b_int_of_nat} using a tail-recursive helper. *)
let rec q1b_int_of_nat (n : nat) : int = 
  let rec nat_counter (count_acc : int ) (nat_repn : nat) = 
    match nat_repn with
    | (a) ->
        if a=n then count_acc else nat_counter (count_acc+1) (S a) in
  nat_counter 0 Z
  
          

(* TODO: Write a good set of tests for {!q1c_add}. *)
let q1c_add_tests : ((nat * nat) * nat) list = [
  ((Z,Z),Z); (((S (S (S Z))),(S Z)),(S (S (S (S Z))))) ; (((S Z),(Z)),(S Z))
]

(* TODO: Implement {!q1c_add}. *)
let rec q1c_add (n : nat) (m : nat) : nat = match n with
  | Z -> m
  | (S b) -> (S (q1c_add b m) )

(* Question 2 *)

(* TODO: Implement {!q2a_neg}. *)
let q2a_neg (e : exp) : exp = 
  Times (Const (-1.0), e)

(* TODO: Implement {!q2b_minus}. *)
let q2b_minus (e1 : exp) (e2 : exp) : exp = 
  Plus (e1,(q2a_neg (e2)))

(* TODO: Implement {!q2c_quot}. *)
let q2c_quot (e1 : exp) (e2 : exp) : exp =
  Times (e1,(Pow (e2,-1))) 

(* Question 3 *)

(* TODO: Write a good set of tests for {!eval}. *)
let eval_tests : ((float * exp) * float) list = [
  ((5.0,Var),5.0) ; ((1.0, (Pow (Var,2))) ,1.0) ;
  ((1.0,Plus( Var, Const (1.0) )),2.0) ;
  ((0.0,(Plus ( Plus ( Times ( Const 2.0,Pow (Var, 2)),
                       Times ((Const (-1.0)), Var) ),Const 10.0))), 10.0)
  
]

(* TODO: Implement {!eval}. *)
let rec eval (a : float) (e : exp) : float = match e with
  | Var -> a
  | Const (x) -> x
  | Plus (e1,e2) -> (eval a e1) +. (eval a e2)
  | Times (e1,e2) -> (eval a e1) *. (eval a e2)
  | Pow (e1, n1) -> (eval a e1) ** float_of_int(n1)








(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = [
  ((Const 1.0),(Const 0.0)); 
  (Var,Const (1.0));
  ((Pow (Var,6)), Times (Times (Const 6.0, Pow (Var,5)) , Const 1.0));
  (Times (Pow (Var,3) , Pow (Var,4)) , Plus (Times (Const 3.0, Pow (Var,2)) ,
                                             Times (Const 4.0, Pow (Var,3))))
]



(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp = 
  e
