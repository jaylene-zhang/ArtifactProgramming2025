(* TODO: Q1a *) 


let rec take (n : int) (s : 'a stream) : 'a list = match n with
  | 0 -> []
  | _ -> s.head :: take (n - 1)  (s.tail () )
           
(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream = match n with
  | 0 -> s
  | _ -> drop (n - 1) (s.tail ())

(* TODO: Q2a *)
let zeroes : int stream =
  unfold (fun a -> (0,a)) (0)  (* can manipulate the acc in the 2nd output of 
                                  fun *)

(* TODO: Q2b *)
let natural_numbers : int stream =
  unfold (fun a -> (a,a + 1)) (0) (* i need to update the seed *)

(* TODO: Q2c *)
let even_numbers : int stream =
  unfold (fun a -> (a,a + 2)) (0) (* i need to update the seed *)

(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  
  let (x, y) =zip s1 s2 in
  {
    head = map x;
    tail = () -> map y
  }
  

(* TODO: Q4a *)
let fibonacci : int stream =
  int_stream_not_implemented

(* TODO: Q4b *)
let lucas : int stream =
  int_stream_not_implemented
