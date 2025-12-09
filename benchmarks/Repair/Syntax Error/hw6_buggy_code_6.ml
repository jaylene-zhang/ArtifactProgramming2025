(* Q1: 5 points *)
let traverse_tests : (((int -> int option) * int list) * int list option) list = [
  (((fun x -> if x >= 0 then Some x else None), [-2; 3; 2; 9]), None); 
  
  (((fun x -> if (x + x * 3) mod 2 = 0 then Some (x*x) else None), [-2; 3; 1]), Some [4; 9; 1])
]

    
let traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option = 
  let rec helper f l acc = match l with 
    | [] -> acc
    | x :: xs -> match (f x) with 
      | Some (y) -> helper f xs (acc @ [y]) 
      | None -> helper f xs acc
  in let acc = helper f l [] in 
  if (List.length acc  = List.length l) then Some acc else None 
  
  
    
    
(* Q2.1: 2 points *)
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind fm (fun y -> (bind mx (fun x -> return (y x))))
  

(* Q2.2: 2 points *)
let seq2 (m1 : 'a1 Maybe.t) (m2 : 'a2 Maybe.t) : ('a1 * 'a2) Maybe.t =
  let open Maybe in
  bind m1 (fun y -> (bind m2 (fun x -> return (y, x))))

(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  let open Maybe in
  fun (x, y) -> seq2 (p1 x) (p2 y)

(* Q2.4: 3 points *)
let map (f : 'a -> 'b) (a : 'a Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind a ( fun x -> return (f x))

(* Q2.5: 10 points *)
let rec traverse' (f : 'a -> 'b Maybe.t) (l : 'a list) : 'b list Maybe.t =
  let open Maybe in
  let rec helper f l acc = match l with 
    | [] -> return acc
    | x :: xs -> 
        bind (f x ) (fun y -> (helper f xs (acc @ [y]) )) 
  in helper f l []  
  

(* Q3.1a: 2 points *)
let church_to_nat (c : 'a church) : nat =
  (c Z (fun x -> S x ));;

(* Q3.1b: 3 points *)
let one : 'b church = fun z s -> s z
let zero : 'b church = fun z s -> z
  
let nat_two = S (S Z)
    
let add (n1 : 'b church) (n2 : 'b church) : 'b church = fun z s -> n1 (n2 z s) s ;;

let nat_to_church (n : nat) : 'a church = 
  let rec helper acc n  = match n with 
    | Z -> acc
    | S (x) -> helper (add acc one) x
  in helper zero n


(* Q3.2a: 2 points *)
let coption_to_option (copt : ('a, 'r) coption) : 'a option = match copt with 
    copt none (fun (x,y) -> Some x)
                

(* Q3.2b: 3 points *)
let option_to_coption (m : 'a option) : ('a, 'r) coption =
  raise NotImplemented

(* Q3.3a: 2 points*)
let rec clist_to_list ((CList clist) : ('a, 'r) clist) : 'a list =
  raise NotImplemented

(* Q3.3b: 3 points *)
let rec list_to_clist (l : 'a list) : ('a, 'r) clist =
  raise NotImplemented

(* Q4: 5 points *)
let rec map_clist (f : 'a -> 'b) (clist : ('a, 'r) clist) : ('b, 'r) clist =
  raise NotImplemented
