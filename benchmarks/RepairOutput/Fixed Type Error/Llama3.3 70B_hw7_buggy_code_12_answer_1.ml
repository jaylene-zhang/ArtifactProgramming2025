let string_implode (l : char list) : string =
  let c = List.map (fun x -> String.make 1 x) l in
  List.fold_left ( ^ ) c ""