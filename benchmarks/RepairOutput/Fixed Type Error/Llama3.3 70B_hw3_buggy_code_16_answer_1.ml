let sum (l : 'b church list) : 'b church =
  List.fold_left (fun a b -> add b a) zero l