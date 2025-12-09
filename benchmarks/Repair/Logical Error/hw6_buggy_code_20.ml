(* Q1: 5 points *)
let traverse_tests : (((int -> int option) * int list) * int list option) list = [
  (((fun x -> Some x), [1;2;3]), Some ([1;2;3]));
  (((fun x -> Some (x+1)), [1;2;3]), Some ([2;3;4]));
  (((fun x -> Some (x*0)), [1;2;3]), Some ([0;0;0]));
  (((fun x -> None), [1;2;3]), None);

  (((fun x -> if x mod 2 = 0 then Some x else None), []), Some []);
  (((fun x -> None), []), Some []);
]
    
                    
let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option = 
  match l with
  | [] -> Some []
  | hd::tl -> 
      match (f hd), (traverse f tl) with 
      | None, _ -> None
      | _ , None -> None
      | Some a, Some b -> Some (a :: b)
          

(* Q2.1: 2 points *)
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  mx >>= fun a ->
  fm >>= fun b ->
  return (b a)
    

(* Q2.2: 2 points *)
let seq2 (m1 : 'a1 Maybe.t) (m2 : 'a2 Maybe.t) : ('a1 * 'a2) Maybe.t =
  let open Maybe in
  m1 >>= fun a ->
  m2 >>= fun b ->
  return (a, b)

(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  raise NotImplemented

(* Q2.4: 3 points *)
let map (f : 'a -> 'b) (a : 'a Maybe.t) : 'b Maybe.t =
  let open Maybe in
  raise NotImplemented

(* Q2.5: 10 points *)
let rec traverse' (f : 'a -> 'b Maybe.t) (l : 'a list) : 'b list Maybe.t =
  let open Maybe in
  raise NotImplemented

(* Q3.1a: 2 points *)
let church_to_nat (c : 'a church) : nat =
  c Z (fun x -> S (x))

(* Q3.1b: 3 points *)
let next_ch c = (fun z s -> s (c z s))

let rec nat_to_church (n : nat) : 'a church =
  match n with 
  | Z -> (fun z s -> z)
  | S x -> next_ch (nat_to_church x)

(* Q3.2a: 2 points *)
let coption_to_option (copt : ('a, 'r) coption) : 'a option =
  raise NotImplemented

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
