(* Q1: 5 points *)
let traverse_tests : (((int -> int option) * int list) * int list option) list = [
  (((fun a -> if a= 1 then Some(a) else None),[1;1]), Some([1;1]));
  (((fun a -> if a= 1 then Some(a) else None),[1;0]), None); 
] 
    
let rec traverse_helper (f : 'a -> 'b option) (l : 'a list) (ls : 'a list) : 'b list option = 
  match l with 
  | [] -> Some (ls)
  | x :: xs -> if f x = None then None else traverse_helper f xs ls
      
let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option = 
  traverse_helper f l l
  
      
(* Q2.1: 2 points *)
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  Maybe.bind mx (fun x -> Maybe.bind fm (fun y -> Maybe.return (y x)))
        

(* Q2.2: 2 points *)
let seq2 (m1 : 'a1 Maybe.t) (m2 : 'a2 Maybe.t) : ('a1 * 'a2) Maybe.t =
  let open Maybe in
  Maybe.bind m1 (fun x -> Maybe.bind m2 (fun y -> Maybe.return (x,y)))

(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (x, y) -> seq2 (p1 x) (p2 y)
    

(* Q2.4: 3 points *)
let map (f : 'a -> 'b) (a : 'a Maybe.t) : 'b Maybe.t =
  let open Maybe in
  ap a (Maybe.return f) 

(* Q2.5: 10 points *)
let rec traverse2_helper (f : 'a -> 'b Maybe.t) (l : 'a list) (ls :'b list Maybe.t ): 'b list Maybe.t=
  match l with
  | [] -> ls 
  | x:: xs -> traverse2_helper f xs (ap (seq2 ls (map (fun l -> [l]) (f x))) (Maybe.return(fun (x,y) -> x @ y)))
                
let rec traverse' (f : 'a -> 'b Maybe.t) (l : 'a list) : 'b list Maybe.t =
  let open Maybe in
  traverse2_helper f l (Maybe.return [])

(* Q3.1a: 2 points *)

let church_to_nat (c : 'a church) : nat =
  c Z (fun x -> S(x))

(* Q3.1b: 3 points *) 
              
let rec helper1 (n : nat) (z : 'a) (s : 'a -> 'a) : 'a = 
  match n with 
  | Z -> z 
  | S n' -> s (helper1 n' z s)
                                                                                           
let rec nat_to_church (n : nat) : 'a church =
  helper1 (n)

(* Q3.2a: 2 points *)
let coption_to_option (copt : ('a, 'r) coption) : 'a option =
  copt (fun x -> Some(x)) (fun x -> None) 

(* Q3.2b: 3 points *)
let option_to_coption (m : 'a option) : ('a, 'r) coption =
  match m with 
  | Some (x) -> (fun x -> x) 
  | None -> (fun unit) 

(* Q3.3a: 2 points*)
let rec clist_to_list ((CList clist) : ('a, 'r) clist) : 'a list =
  raise NotImplemented

(* Q3.3b: 3 points *)
let rec list_to_clist (l : 'a list) : ('a, 'r) clist =
  raise NotImplemented

(* Q4: 5 points *)
let rec map_clist (f : 'a -> 'b) (clist : ('a, 'r) clist) : ('b, 'r) clist =
  raise NotImplemented