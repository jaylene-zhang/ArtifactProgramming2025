let string_implode (l : char list) : string =
  let c = List.map Char.escaped l in
  List.fold_left (fun acc s -> acc ^ s) "" c