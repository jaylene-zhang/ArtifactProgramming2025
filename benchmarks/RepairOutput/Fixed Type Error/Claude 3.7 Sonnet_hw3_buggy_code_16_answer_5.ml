let sum (l : 'b church list) : 'b church =
  match l with
  | [] -> zero
  | x::xs -> List.fold_left add x xs