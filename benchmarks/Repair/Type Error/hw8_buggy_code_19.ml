
(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 1 -> fun () -> s.tail
  | _ -> drop (n-1) (s)
