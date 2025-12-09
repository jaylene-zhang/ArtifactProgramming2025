(* Q1: 5 points *)
let func_1 = fun x -> Some x
let func_2 = fun x -> None
let func_3 x: int option = if x mod 2 = 0 then Some (x/2) else None 
let traverse_tests : (((int -> int option) * int list) * int list option) list = [
  ((func_1, [1;2;3]), Some [1;2;3]); 
  ((func_2, [1;2;3]), None);
  ((func_3, [2;4;6]), Some [1;2;3]);
  ((func_3, [2;4;6;8;10]), Some [1;2;3;4;5]);
  ((func_3, [2;4;6;9]), None); 
]

let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option = 
  let rec traverse_helper f l acc: 'b list option =
    match l with
    | [] -> Some acc
    | ele::rest -> match f ele with
      | None -> None 
      | Some x -> traverse_helper f rest (acc@[x])
  in
  traverse_helper f l []
  
(* Q2.1: 2 points *)
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in 
  bind mx (fun x -> bind fm (fun func -> return (func x)))

(* Q2.2: 2 points *)
let seq2 (m1 : 'a1 Maybe.t) (m2 : 'a2 Maybe.t) : ('a1 * 'a2) Maybe.t =
  let open Maybe in
  bind m1 (fun x1 -> bind m2 (fun x2 -> return (x1, x2)))

(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (x, y) -> seq2 (p1 x) (p2 y)

(* Q2.4: 3 points *)
let map (f : 'a -> 'b) (a : 'a Maybe.t) : 'b Maybe.t =
  let open Maybe in
  ap a (return f) 

(* Q2.5: 10 points *)
let rec traverse' (f : 'a -> 'b Maybe.t) (l : 'a list) : 'b list Maybe.t =
  let open Maybe in
  raise NotImplemented

(* Q3.1a: 2 points *)
let church_to_nat (c : 'a church) : nat =
  c Z (fun x -> S x)

(* Q3.1b: 3 points *)
let rec nat_to_church (n : nat) : 'a church =
  match n with
  | Z -> (fun z s -> z)
  | S rest -> (fun z s -> s ((nat_to_church rest) z s))  
              
(* Q3.2a: 2 points *)
let coption_to_option (copt : ('a, 'r) coption) : 'a option =
  copt (fun x -> Some x) (fun () -> None)

(* Q3.2b: 3 points *)
let option_to_coption (m : 'a option) : ('a, 'r) coption =
  match m with
  | None -> fun success fail -> fail()
  | Some x -> fun success fail -> success x

(* Q3.3a: 2 points*)
let rec clist_to_list ((CList clist) : ('a, 'r) clist) : 'a list =
  raise NotImplemented

(* Q3.3b: 3 points *)
let rec list_to_clist (l : 'a list) : ('a, 'r) clist =
  raise NotImplemented

(* Q4: 5 points *)
let rec map_clist (f : 'a -> 'b) (clist : ('a, 'r) clist) : ('b, 'r) clist =
  raise NotImplemented
