let sum (l : 'b church list) : 'b church =
  match l with
  | [] -> zero
  | x::xs -> List.fold_left (fun acc n -> add acc n) x xs