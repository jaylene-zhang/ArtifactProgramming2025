let string_implode (l : char list) : string =
  let char_strings = List.map Char.escaped l in
  List.fold_left (fun acc s -> acc ^ s) "" char_strings