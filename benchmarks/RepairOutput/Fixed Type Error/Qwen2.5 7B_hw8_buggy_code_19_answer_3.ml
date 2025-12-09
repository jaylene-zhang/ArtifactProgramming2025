**Error Type in the following code: **Type Error
***compiler error message(IGNORE position info)**
File "/Users/jaylene/Desktop/LLM_Eval/F2022/exercises/hw8/solution.ml", line 10, characters 39-118:
This expression has type 'a -> 'b
       but an expression was expected of type 'c stream

grader outcomes:
val print_html : 'a -> 'b = <fun>
exception NotImplemented
type 'a stream = { head : 'a; tail : unit -> 'a stream; }
val unfold : ('a -> 'b * 'a) -> 'a -> 'b stream = <fun>
val map : ('a -> 'b) -> 'a stream -> 'b stream = <fun>
val find : ('a -> bool) -> 'a stream -> 'a * 'a stream = <fun>
val filter : ('a -> bool) -> 'a stream -> 'a stream = <fun>
val zip : 'a stream -> 'b stream -> ('a * 'b) stream = <fun>
val int_stream_not_implemented : int stream = {head = 0; tail = <fun>}
val ( := ) : 'a -> 'b -> 'c = <fun>
val ignore : 'a -> 'b = <fun>
**Buggy Code to be fixed**

(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 1 -> s.tail ()
  | _ -> drop (n-1) (s.tail ())