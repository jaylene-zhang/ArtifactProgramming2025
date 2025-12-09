let sum (l : 'b church list) : 'b church =
  match l with
  | [] -> zero
  | h::t -> List.fold_left (fun acc x -> add acc x) h t