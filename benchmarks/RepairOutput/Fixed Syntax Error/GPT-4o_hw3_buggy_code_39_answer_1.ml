```ocaml
(* Question 1a: Church numeral to integer *)
(* TODO: Test cases *)
type 'b church = 'b -> ('b -> 'b) -> 'b

let five : 'b church = fun z s -> s (s (s (s (s z))))
let four : 'b church = fun z s -> s (s (s (s z)))
let zero : 'b church = fun z s -> z
let one : 'b church = fun z s -> s z
let to_int_tests : (int church * int) list = [(zero, 0); (one, 1); (five, 5)]

(* TODO: Implement *)
let to_int (n : int church) : int = n 0 (fun x -> x + 1)

(* Question 1b: Add two church numerals *)
(* TODO: Test cases *)
let add_tests : (('b church * 'b church) * 'b church) list =
  [((one, zero), one); ((zero, five), five); ((one, four), five)]

let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z s -> n1 (n2 z s) s

(* Question 1c: Multiply two church numerals *)
(* TODO: Test cases *)
let mult_tests : (('b church * 'b church) * 'b church) list =
  [((one, zero), zero); ((zero, five), zero); ((one, four), four)]

let mult (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z s -> n1 (n2 z s) (fun x -> s x)

(* Question 2a: Sum a list of church numerals *)
(* TODO: Test cases *)
let sum_tests : ('b church list * 'b church) list = []

let sum (l : 'b church list) : 'b church =
  List.fold_left add zero l

(* Question 2b: Compute the length of a list as a church numeral *)
(* TODO: Test cases. Use ONLY lists of ints! Do not use lists of anything else. *)
let length_tests : (int list * 'b church) list = []

let length (l : 'a list) : 'b church =
  List.fold_left (fun acc _ -> fun z s -> s (acc z s)) zero l
```