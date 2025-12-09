let string_implode (l : char list) : string =
  let string_list = List.map Char.escaped l in
  List.fold_left (^) "" string_list