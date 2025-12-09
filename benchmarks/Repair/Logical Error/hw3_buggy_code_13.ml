(* Hi everyone. All of these problems are generally "one-liners" and have slick solutions. They're quite cute to think
   about but are certainly confusing without the appropriate time and experience that you devote towards reasoning about
   this style. Good luck! :-)  *)

(* WARNING: You could encounter weird issues if you try to be clever and write a function to generate church numerals
   for you due to limitations of the type system, although I did make a best effort to make sure that doesn't happen...
*)
(* For example, if you wanted to use the encoding of five in your test cases, you could define: *)
let five : 'b church = fun z s -> s ( s ( s ( s ( s z))))
let ten : 'b church = fun z s -> s ( s ( s ( s ( s (s ( s (s (s (s z)))))))))
let two : 'b church = fun z s -> s (s z)
(* and use 'five' like a constant. You could also just use
 'fun z s -> s ( s ( s ( s ( s z))))' directly in the test cases too. *)
(* If you defined a personal function like int_to_church, use it for your test cases, and see things break, you should
   suspect it
   and consider hard coding the input cases instead *)


(* Question 1a: Church numeral to integer *)
(* TODO: Test cases *)
let to_int_tests : (int church * int) list = [
  ((fun z s -> z) ,0); ((fun z s -> s (s (s (s z)))),4)
]
;;

(* TODO: Implement
   Although the input n is of type int church, please do not be confused. This is due to typechecking reasons, and for
   your purposes, you could pretend n is of type 'b church just like in the other problems.
*)
let to_int (n : int church) : int = n 0 (fun x -> x + 1)

(* Question 1b: Add two church numerals *)
(* TODO: Test cases *)
let add_tests : ( ('b church * 'b church) * 'b church) list = [
  ((zero,zero),zero); ((zero,five),five);((five,five),ten)
]
;;

let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z s -> n2 (n1 z s) s

(* Question 1c: Multiply two church numerals *)
(* TODO: Test cases *)
let mult_tests : ( ('b church * 'b church) * 'b church) list = [
  ((zero,zero),zero);((five,one),five);((two,five),ten)
]
;;

let mult (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z s -> n2 (n1 z s) s

(* Question 2a: Sum a list of church numerals *)
(* TODO: Test cases *)
let sum_tests : ( ('b church) list * 'b church) list = [
]
;;

let sum (l : 'b church list) : 'b church =
  raise NotImplemented

(* Question 2b: Compute the length of a list as a church numeral *)
(* TODO: Test cases. Use ONLY lists of ints! Do not use lists of anything else.
   For example,
    OK - ([1;3;6;2;3], five)
    NO - ([true; false; true; true; true], five)
    This is due to bureaucratic reasons in the type system....
*)
let length_tests : (int list * 'b church) list = [
]
;;

(* Although the test cases above are written only for l : int list, the length function itself should accept any 'a
   list, not just int list. So you should not assume any properties about individual elements in the list. *)
let length (l : 'a list) : 'b church =
  raise NotImplemented

