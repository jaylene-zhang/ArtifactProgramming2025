let rec drop (n : int) (s : 'a stream) : 'a stream =
  if n <= 0 then s
  else drop (n - 1) (s.tail ())
