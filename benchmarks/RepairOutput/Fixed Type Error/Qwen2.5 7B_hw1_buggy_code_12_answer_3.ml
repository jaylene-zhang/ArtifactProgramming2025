let rec lucas_helper l0 l1 k : int =
  if k = 0 then l0
  else if k = 1 then
    lucas_helper l1 (l0 + l1) (k-1)
  else
    lucas_helper (l1) ((l0 + l1)) (k-1)


(* TODO: Implement lucas that calls the previous function. *)
let lucas n = 
  lucas_helper 2 1 n