let string_explode (s : string) : char list =
  let rec explode n acc =
    if n > 0 then explode (n - 1) ((String.get s (n - 1)) :: acc)
    else acc
  in
  explode (String.length s) []