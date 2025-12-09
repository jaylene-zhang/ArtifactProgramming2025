let to_int (n : int church) : int = 
  n (fun x -> x + 1) 0