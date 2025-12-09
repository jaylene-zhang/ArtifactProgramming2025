(* Question 1 *)

(* TODO: Write a good set of tests for {!q1a_nat_of_int}. *)
let q1a_nat_of_int_tests : (int * nat) list = [
  (0,Z); 
  (1,S Z);
  (5, S ( S (S (S (S Z)))));
]

(* TODO:  Implement {!q1a_nat_of_int} using a tail-recursive helper. *) 

    (* let rec  q1a_nat_of_int (n : int) : nat = match n with
        |0 -> Z
        |_ -> S(q1a_nat_of_int (n-1)) *)

let q1a_nat_of_int (n : int) : nat = 
  let rec go (acc : nat) n : nat = match n with
    |0 -> acc
    |_ -> let acc = S(acc) in
        go acc (n-1)
  in go Z n 
              
(* TODO: Write a good set of tests for {!q1b_int_of_nat}. *)
let q1b_int_of_nat_tests : (nat * int) list = [
  (Z,0); 
  (S Z, 1);
  (S ( S (S (S (S Z)))), 5); 
]

(* TODO:  Implement {!q1b_int_of_nat} using a tail-recursive helper. *)
let q1b_int_of_nat (n : nat) : int = 
  let rec go (acc : int) (n : nat) : int = match n with
    |Z -> acc
    |S(v) -> let n = v in
        go (acc+1) (n)
  in go 0 n

(* TODO: Write a good set of tests for {!q1c_add}. *)
let q1c_add_tests : ((nat * nat) * nat) list = [
  ((Z,S Z),S Z);
  ((Z,Z),Z);
  ((S (S (S Z)),S (S (S (S Z)))),S( S( S ( S (S (S (S Z)))))));
]

(* TODO: Implement {!q1c_add}. *)
let rec q1c_add (n : nat) (m : nat) : nat = 
  match (n,m) with
  |(Z,m) -> m
  |(n,Z) -> n
  |(n,S(b)) -> S(q1c_add n b)


(* Question 2 *)

(* TODO: Implement {!q2a_neg}. *)
let q2a_neg (e : exp) : exp = Times(Const(-1.0), e)

(* TODO: Implement {!q2b_minus}. *)
let q2b_minus (e1 : exp) (e2 : exp) : exp = Plus(e1, q2a_neg e2)

(* TODO: Implement {!q2c_quot}. *)
let q2c_quot (e1 : exp) (e2 : exp) : exp = Times(e1,Pow(e2,-1))


(* Question 3 *)

(* TODO: Write a good set of tests for {!eval}. *)
let eval_tests : ((float * exp) * float) list = [ 
  
  ((55.0,Plus(Const(5.0),Const(5.0))),10.0);
  
  ((55.0,Times(Const(5.0),Const(-5.0))),-25.0); 
  
  ((55.0,Var),55.0);
  
  ((55.0,Pow(Const(0.0),-1)),infinity); 

]

(* TODO: Implement {!eval}. *)
let rec eval (a : float) (e : exp) : float = match e with
  |Var -> a
  |Const(v) -> v
  |Plus(v1,v2) -> eval a v1 +. eval a v2
  |Times(v1,v2) -> eval a v1 *. eval a v2
  |Pow(v1,i) -> eval a v1 ** float_of_int i

(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = []

(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp = raise Not_implemented
