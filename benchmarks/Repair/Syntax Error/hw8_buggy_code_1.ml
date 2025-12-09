(* TODO: Q1a *)
let rec take (n : int) (s : 'a stream) : 'a list =
  s.head ::( take (n-1) (s.tail ()))

(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream =
  if n = 0 then s else drop (n-1) (s.tail ())

(* TODO: Q2a *)
let zeroes : int stream =
  unfold ( fun _ -> (0,0)) 0

(* TODO: Q2b *)
let natural_numbers : int stream =
  unfold (fun x -> (x,x+1)) 0

(* TODO: Q2c *)
let even_numbers : int stream =
  unfold (fun x -> (x,x+2)) 0

(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  { head: f (s1.head) (s2.head);
    tail: fun () -> map2 f (s1.tail ()) (s2.tail ())
  }

(* TODO: Q4a *)
let fibonacci : int stream =
  int_stream_not_implemented

(* TODO: Q4b *)
let lucas : int stream =
  int_stream_not_implemented
