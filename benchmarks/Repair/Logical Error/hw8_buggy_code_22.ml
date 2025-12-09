(* TODO: Q1a *)
let rec take (n : int) (s : 'a stream) : 'a list =
  let rec helper current_n current_stream acc = 
    match current_n with
    |0-> List.rev acc
    |_-> helper (current_n-1) (current_stream.tail()) (current_stream.head::acc)
  in 
  helper n s []
  
  
(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream = 
  match n with
  |0 -> s
  |_ -> drop (n-1) (s.tail()) 
  
(* TODO: Q2a *)
let zeroes : int stream =
  unfold (fun x-> (x,x)) (0)

(* TODO: Q2b *)
let natural_numbers : int stream =
  unfold (fun x-> (x,x+1)) (0)

(* TODO: Q2c *)
let even_numbers : int stream =
  unfold (fun x -> (x , x+2)) (0)

  
(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  zip s1 s2
    
(* TODO: Q4a *)
let fibonacci : int stream =
  int_stream_not_implemented

(* TODO: Q4b *)
let lucas : int stream =
  int_stream_not_implemented
