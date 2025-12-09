let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 0 -> s
  | _ -> drop (n-1) ({head = s.head; tail = fun () -> s.tail ()})