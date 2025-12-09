(* Question 1 *)

(* TODO: Write a good set of tests for {!q1a_nat_of_int}. *)
let q1a_nat_of_int_tests : (int * nat) list = [(0,Z);(3,S(S(S Z)))]

(* TODO:  Implement {!q1a_nat_of_int} using a tail-recursive helper. *)
let rec q1a_nat_of_int (n : int) : nat = 
  
  if n = 0 then Z else
    
    (*helper function takes an accumulator which stores the prev natural 
    
    number and k *)
    
    let rec helperA (a : nat) (k:int) : nat = 
      if k = 0 then a else helperA (S(a)) (k-1) in
    
     (*
         Let's say we enter helperA Z 3
    
    Next we get helperA (S Z) 2
      Next we get S(S Z) 1
    
    Next we get S(S(S Z)) 0
    
    so we return a which is S(S(S Z))
    
    So, it makes sense to start with helperA Z n 
      
         *)
    
    helperA Z n
          
    


(* TODO: Write a good set of tests for {!q1b_int_of_nat}. *)
let q1b_int_of_nat_tests : (nat * int) list = [(Z,0);((S(S(S Z))),3)]

(* TODO:  Implement {!q1b_int_of_nat} using a tail-recursive helper. *)

(* very similar logic to part a

   just instead accumulator was int and it was updated by a+1 and 
     the arguement was the inner part of S which was extracted by pattern matching
*)

let rec q1b_int_of_nat (n : nat) : int = 
  
  if n=Z then 0 else
    
    let rec helperB (a : int ) (k : nat) = 
      
      match k with 
      
      | Z -> a
      
      | S(remaining) -> helperB (a+1) (remaining)
          
    in helperB 0 n 
  
  

(* TODO: Write a good set of tests for {!q1c_add}. *)
let q1c_add_tests : ((nat * nat) * nat) list = [
  (((S(S(S Z))),(S(S(S Z)))),S (S (S (S (S (S Z))))));
  ((Z,Z),Z)
]

(* TODO: Implement {!q1c_add}. *)
let rec q1c_add (n : nat) (m : nat) : nat = 

      (*
    
    Idea is to replace the Z in n with m
    
    We will match n
  
  if Z, then we return m because only m will exist
      else, 
        we extract the inner remaining part inside S
          then we form a new S and call the function inside it and add the 
            remaining part and m recursively till we find Z in n and add m to it
  and the sum is thus returned
  *)
  
  match n with 
  | Z -> m
  | S(remaining) -> S(q1c_add remaining m)
  

(* Question 2 *)

(* TODO: Implement {!q2a_neg}. *)
let q2a_neg (e : exp) : exp = 
  Times ( Const (-1.0), e)
  

(* TODO: Implement {!q2b_minus}. *)
let q2b_minus (e1 : exp) (e2 : exp) : exp = 
  
  Plus(e1, q2a_neg e2)
  

(* TODO: Implement {!q2c_quot}. *)
let q2c_quot (e1 : exp) (e2 : exp) : exp = 

  (*
  e1 * e2 ^ -1
     *)  
  Times (e1, Pow(e2, -1) )

(* Question 3 *)

(* TODO: Write a good set of tests for {!eval}. *)
let eval_tests : ((float * exp) * float) list = [((1.0,Plus (
    Plus (
      Times (
        Const 3.0,
        Pow (Var, 2)
      ),
      Times (Const (-2.0), Var)
    ),
    Const 15.0
  )),16.0);]

  
(* TODO: Implement {!eval}. *)
let rec eval (a : float) (e : exp) : float = 
  match e with 
  
  | Plus (ex1,ex2) -> eval a ex1 +. eval a ex2 
  | Times (ex1,ex2) ->  eval a ex1 *. eval a ex2
  | Pow (expression,exponent)->  eval a expression ** float_of_int exponent
  | Const n -> n
  | Var -> a
  

(* Question 4 *)

(* TODO: Write a good set of tests for {!diff_tests}. *)
let diff_tests : (exp * exp) list = []

(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp =
  
  
  match e with 
  | Var -> Const 1.0
  | Const n -> Const 0.0
  | Plus (ex1, ex2) -> Plus(diff ex1, diff ex2)
  | Times (ex1, ex2) -> Plus(Times (diff ex1, ex2), Times(diff ex2, ex1) )
  | Pow (ex,n) -> Times(diff ex,Times(Const float_of_int n, Pow(ex,n-1)))
  
    
    








