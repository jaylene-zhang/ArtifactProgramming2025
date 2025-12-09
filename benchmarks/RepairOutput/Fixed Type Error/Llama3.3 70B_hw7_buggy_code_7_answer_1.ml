let string_implode (l : char list) : string =
  List.fold_left (fun x y -> x ^ (Char.escaped y)) "" l