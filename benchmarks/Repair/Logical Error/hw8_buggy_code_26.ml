(* TODO: Q1a *)
let rec take (n : int) (s : 'a stream) : 'a list =
  let counter =  n in 
  let rec take_helper counter s acc = match counter with 
    | 0 -> List.rev acc
    | _ -> take_helper (counter - 1 ) (s.tail ()) (s.head :: acc)
  in take_helper counter s []

(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 0 -> (s)
  | _ -> drop (n - 1 ) (s.tail ()) 
           

(* TODO: Q2a *)
let zeroes : int stream =
  unfold (fun _ -> (0,0)) 0

(* TODO: Q2b *)
let natural_numbers : int stream =
  unfold (fun a -> (a,a+1)) 0

(* TODO: Q2c *)
let even_numbers : int stream =
  unfold (fun a -> (a, a+2)) 0

(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  let zipped = zip s1 s2 in 
  map (fun (x,y) -> f x y ) zipped
  
(* TODO: Q4a *)
let rec fibonacci : int stream =
  unfold (fun(x,y) -> (x, (y,x+y))) (0,1)

(* TODO: Q4b *)
let lucas : int stream =
  int_stream_not_implemented
