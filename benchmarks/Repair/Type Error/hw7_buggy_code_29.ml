
(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  let l= List.map (Char.escaped) l in
  List.fold_left (List.map) (l)
