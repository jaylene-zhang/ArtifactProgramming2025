let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with
  | 0 -> s
  | _ -> drop (n - 1) (s.tail ())