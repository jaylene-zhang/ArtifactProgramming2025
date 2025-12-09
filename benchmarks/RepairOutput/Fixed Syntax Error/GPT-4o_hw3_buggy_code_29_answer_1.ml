```ocaml
(* Fixed Code *)

type 'b church = { f : ('b -> 'b) -> ('b -> 'b) }

let five : 'b church = { f = fun z s -> s (s (s (s (s z)))) }

(* Question 1a: Church numeral to integer *)
(* TODO: Test cases *)
let to_int_tests : (int church * int) list = [
]

let to_int (n : int church) : int =
  n.f (fun x -> x + 1) 0

(* Question 1b: Add two church numerals *)
(* TODO: Test cases *)
let add_tests : (('b church * 'b church) * 'b church) list = [
]

let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  { f = fun fn x -> n2.f fn (n1.f fn x) }

(* Question 1c: Multiply two church numerals *)
(* TODO: Test cases *)
let mult_tests : (('b church * 'b church) * 'b church) list = [
]

let mult (n1 : 'b church) (n2 : 'b church) : 'b church =
  { f = fun fn x -> n1.f (n2.f fn) x }

(* Question 2a: Sum a list of church numerals *)
(* TODO: Test cases *)
let sum_tests : (('b church) list * 'b church) list = [
]

let sum (l : 'b church list) : 'b church =
  List.fold_left add { f = (fun f x -> x) } l

(* Question 2b: Compute the length of a list as a church numeral *)
(* TODO: Test cases *)
let length_tests : (int list * 'b church) list = [
]

let length (l : 'a list) : 'b church =
  { f = fun fn x -> List.fold_left (fun acc _ -> fn acc) x l }
```