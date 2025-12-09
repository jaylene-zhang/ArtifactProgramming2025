(* Q1: 5 points *)
let f a = 
  if a mod 2 = 1 then
    None
  else Some(0)
      
let traverse_tests : (((int -> int option) * int list) * int list option) list = [
  ((f, [2;4;6;6;7;7]), None);
  ((f, [2;4;6;6;8;8]), Some([0;0;0;0;0;0]));
]

let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option =
  let rec helper f l nl = 
    match l with
    | [] -> Some(nl)
    | x :: xs -> 
        let y = f x in
        match y with
        | None -> None
        | Some t -> helper f xs (nl @ [t]) 
  in
  helper f l []
    
(* Q2.1: 2 points *)
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind mx (fun x -> bind fm (fun y -> return (y x)))


(* Q2.2: 2 points *)
let seq2 (m1 : 'a1 Maybe.t) (m2 : 'a2 Maybe.t) : ('a1 * 'a2) Maybe.t = 
  let open Maybe in
  bind m1 (fun x -> bind m2 (fun y -> return (x,y)))
  
  
(* Q2.3: 3 points *)
let seq_predicate2 (p1 : 'a1 -> 'b1 Maybe.t) (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  let open Maybe in
  fun (a,b) ->  bind (p1 a) (fun x -> bind (p2 b) (fun y -> return (x,y)))
      
(* Q2.4: 3 points *)
let map (f : 'a -> 'b) (a : 'a Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind a (fun x ->return(f x))

(* Q2.5: 10 points *)
let rec traverse' (f : 'a -> 'b Maybe.t) (l : 'a list) : 'b list Maybe.t =
  let open Maybe in 
  
  (* We want a function that takes 'b Maybe.t and adds it to a list of type 'b list Maybe.t*)
  
  let rec tmp1 (l1 : 'a list) : 'b list Maybe.t =
    match l1 with
    | [] -> return []
    | x :: xs -> 
        let subp = tmp1 xs in
        let tmp2 (smth : 'b) : 'b list Maybe.t =
          let tmp3 (sj : 'b list) : 'b list Maybe.t =
            return (smth :: sj)
          in
          bind subp tmp3
        in
        bind (f x) tmp2
  in
  tmp1 l

(* Q3.1a: 2 points *)
let church_to_nat (c : 'a church) : nat =
  c Z (fun x -> S(x))

(* Q3.1b: 3 points *)
let rec nat_to_church (n : nat) : 'a church = 
  raise NotImplemented
             
  
(* Q3.2a: 2 points *)
let coption_to_option (copt : ('a, 'r) coption) : 'a option = 
  copt (fun x -> Some x) (fun () -> None)
    
(* Q3.2b: 3 points *)
let option_to_coption (m : 'a option) : ('a, 'r) coption =
  match m with 
  | None -> fun f l -> l()
  | Some x -> fun f l -> f x
      

(* Q3.3a: 2 points*)
let rec clist_to_list ((CList clist) : ('a, 'r) clist) : 'a list =
  (*clist (fun x xs  -> x :: xs) (fun ()  -> [])*)
      
(* Q3.3b: 3 points *)
  let rec list_to_clist (l : 'a list) : ('a, 'r) clist =
    match l with 
    | [] -> fun f l -> l()
    | x:: xs -> fun f l -> f x xs
      
(* Q4: 5 points *)
let rec map_clist (f : 'a -> 'b) (clist : ('a, 'r) clist) : ('b, 'r) clist =
  raise NotImplemented
