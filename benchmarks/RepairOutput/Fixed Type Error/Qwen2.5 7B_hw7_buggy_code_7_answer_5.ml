let string_implode (l : char list) : string =
  List.fold_left (fun acc x -> acc ^ String.make 1 x) "" l