let string_implode (l : char list) : string =
  List.map (fun x -> Char.escaped x) l |> String.concat ""