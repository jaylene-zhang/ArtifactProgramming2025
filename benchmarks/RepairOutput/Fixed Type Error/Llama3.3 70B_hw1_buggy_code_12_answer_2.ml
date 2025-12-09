let rec lucas_helper l0 l1 k : unit =
  if k = 0 then print_int l0
  else if k = 1 then
    lucas_helper l1 (l0 + l1) (k-1)
  

(* TODO: Implement lucas that calls the previous function. *)
let lucas n = 
  lucas_helper 2 1 n; ()