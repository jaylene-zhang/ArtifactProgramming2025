let string_explode (s : string) : char list =
  let rec explode n acc =
    if n = 0 then acc
    else explode (n - 1) ((String.get s (n - 1)) :: acc)
  in
  explode (String.length s) []