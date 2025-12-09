```ocaml
let rec lucas_helper l0 l1 k : int =
  if k = 0 then l0
  else lucas_helper l1 (l0 + l1) (k-1)
  

(* TODO: Implement lucas that calls the previous function. *)
let lucas n = 
  if n = 0 then 2
  else lucas_helper 2 1 n
```