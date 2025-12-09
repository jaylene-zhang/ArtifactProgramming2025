
let string_implode (l : char list) : string =
  List.map (fun x -> String.concat "" (Char.escaped x)) l
    
