```ocaml
(* Q1: 5 points *)
let traverse_tests : (((int -> int option) * int list) * int list option) list = []

let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option = 
  let rec helper acc l = 
    match l with 
    | [] -> Some(acc)
    | h :: t -> 
        let x = f h in 
        match x with
        | Some x -> helper (x :: acc) t
        | None -> None 
  in 
  helper [] (List.rev l)
;;

(* Q2.1: 2 points *)
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind fm (fun f -> bind mx (fun x -> return (f x)))

(* Q2.2: 2 points *)
let seq2 (m1 : 'a1 Maybe.t) (m2 : 'a2 Maybe.t) : ('a1 * 'a2) Maybe.t =
  let open Maybe in
  bind m1 (fun x1 -> bind m2 (fun x2 -> return (x1, x2)))

(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t =
  fun (x1, x2) ->
    let open Maybe in
    bind (p1 x1) (fun y1 -> bind (p2 x2) (fun y2 -> return (y1, y2)))

(* Q2.4: 3 points *)
let map (f : 'a -> 'b) (a : 'a Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind a (fun x -> return (f x))

(* Q2.5: 10 points *)
let rec traverse' (f : 'a -> 'b Maybe.t) (l : 'a list) : 'b list Maybe.t =
  let open Maybe in
  match l with
  | [] -> return []
  | h :: t ->
      bind (f h) (fun x ->
          bind (traverse' f t) (fun xs -> return (x :: xs)))

(* Q3.1a: 2 points *)
let church_to_nat (c : 'a church) : nat =
  c (fun x -> x + 1) 0

(* Q3.1b: 3 points *)
let rec nat_to_church (n : nat) : 'a church =
  fun f x -> if n = 0 then x else f (nat_to_church (n - 1) f x)

(* Q3.2a: 2 points *)
let coption_to_option (copt : ('a, 'r) coption) : 'a option =
  copt Some None

(* Q3.2b: 3 points *)
let option_to_coption (m : 'a option) : ('a, 'r) coption =
  match m with
  | None -> fun _ n -> n
  | Some x -> fun s _ -> s x

(* Q3.3a: 2 points*)
let rec clist_to_list ((CList clist) : ('a, 'r) clist) : 'a list =
  clist (fun x xs -> x :: clist_to_list xs) []

(* Q3.3b: 3 points *)
let rec list_to_clist (l : 'a list) : ('a, 'r) clist =
  match l with
  | [] -> CList (fun _ nil -> nil)
  | x :: xs -> CList (fun cons nil -> cons x (list_to_clist xs))

(* Q4: 5 points *)
let rec map_clist (f : 'a -> 'b) (clist : ('a, 'r) clist) : ('b, 'r) clist =
  match clist with
  | CList inner -> CList (fun cons nil -> inner (fun x xs -> cons (f x) (map_clist f xs)) nil)
```