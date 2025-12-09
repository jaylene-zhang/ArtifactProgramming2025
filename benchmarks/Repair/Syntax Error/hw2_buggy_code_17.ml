let q1a_nat_of_int_tests : (int * nat) list = [
  (0,Z);
  (1,(S Z));
  (2,S(S Z));
  (3,S(S(S Z)));
  (4,S(S(S(S Z))));
  (5,S(S(S(S(S Z)))));
  (6,S(S(S(S(S(S Z))))));
  (7,S(S(S(S(S(S(S Z)))))));
  (8,S(S(S(S(S(S(S(S Z))))))));
  (9,S(S(S(S(S(S(S(S(S Z)))))))));
  (10,S(S(S(S(S(S(S(S(S(S Z))))))))))
]
;; 

let q1a_nat_of_int (n : int) : nat =
  let rec innerHelper (accumulator:int) (n:int) (natAcc:nat): nat =
    if accumulator = n then natAcc
    else innerHelper (accumulator+1) (n) (S natAcc)
  in innerHelper 0 n Z 
;;

let q1b_int_of_nat_tests : (nat * int) list = [
  (Z,0);
  ((S Z),1);
  (S(S Z),2);
  (S(S(S Z)),3);
  (S(S(S(S Z))),4);
  (S(S(S(S(S Z)))),5);
  (S(S(S(S(S(S Z))))),6);
  (S(S(S(S(S(S(S Z)))))),7);
  (S(S(S(S(S(S(S(S Z))))))),8);
  (S(S(S(S(S(S(S(S(S Z)))))))),9);
  (S(S(S(S(S(S(S(S(S(S Z))))))))),10)
]
;;

let q1b_int_of_nat (n : nat) : int = 
  let rec innerHelper (accumulator:nat) (n:nat) (intAcc:int): int =
    if accumulator = n then intAcc
    else innerHelper (S accumulator) (n) (intAcc+1)
  in innerHelper Z n 0 
;;

let q1c_add_tests : ((nat * nat) * nat) list = [
  ((Z,Z),Z);
  ((Z,(S Z)),(S Z));
  (((S Z),Z),(S Z)); 
  (((S Z),(S Z)),S(S Z))
]
;;

let rec q1c_add (n:nat) (m:nat) : nat = 
  match n with
  | Z -> m 
  | S(a) -> S(q1c_add a m)
;;


let q2a_neg (e : exp) : exp = Times (e,Const (-1.0)) ;;

let q2b_minus (e1 : exp) (e2 : exp) : exp = Plus (e1,q2a_neg (e2)) ;;

let q2c_quot (e1 : exp) (e2 : exp) : exp = Times (e1,Pow(e2,-1)) ;;

let eval_tests : ((float * exp) * float) list = [
  ((0.0,Var),0.0);
  ((4.7,Const 4.0),4.0);
  ((2.0,Plus(Const 2.0,Const 2.0)),4.);
  ((6.0,Plus(Var,Var)),12.0);
  ((2.0,Times(Plus(Const 5.0,Const 5.0),Plus(Const 6.0,Const 6.0))),120.);
  ((5.0,Pow (Times (Plus(Const 2.0,Const 3.0),Plus(Const 6.0,Const 7.0)),2)),4225.)
]
;;

let rec eval (a:float) (e:exp) : float =  
  match e with
  | Const x -> x
  | Var -> a
  | Plus (exp1,exp2) -> eval a (exp1) +. eval a (exp2)
  | Times (exp1,exp2) -> eval a (exp1) *. eval a (exp2)
  | Pow (exp1,int1) -> eval a (exp1) ** (float_of_int(int1))
;;

let diff_tests : (exp * exp) list = [
  (Const 2.0,Const 0.0);
  (Var,Const 1.0);
  (Plus(Const 5.0,Const 6.0),Const 0.0);
  (Plus((Times(Const 6.0,Const 7.0),Times(Const 7.0,Const 9.0))),Const 0.0);
]
;;

let rec diff (e:exp) : exp = 
  match e with
  | Const x -> Const 0.0
  | Var -> Const 1.0
             
  | Plus (exp1,exp2) -> Const (
      (eval 1.0 (Plus
                   (diff exp1,
                    diff exp2))
      )
    )

  | Times (exp1,exp2) -> Const ( 
      (eval 1.0 
         (
           Plus(
             (Times((diff exp1),(exp2))),
             (Times ((exp1),(diff exp2)))
           )
         )
      )
    )
      
  | Pow (exp1,int1) -> Const (
      eval 1.0 (
        Times ((Times ((Const (float_of_int int1)),(Pow((exp1),(int1-1))))),(diff exp1))
      )
      ;;

