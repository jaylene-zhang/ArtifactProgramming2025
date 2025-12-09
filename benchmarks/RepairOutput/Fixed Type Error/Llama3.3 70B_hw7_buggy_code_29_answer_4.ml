let string_implode (l : char list) : string =
  let l= List.map (fun c -> String.make 1 c) l in
  List.fold_left (fun acc x -> acc ^ x) "" l