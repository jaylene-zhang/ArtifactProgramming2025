```OCaml
(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  let rec explode s n acc =
    if n < 0 then acc
    else explode s (n - 1) (String.get s n) :: acc
  in
  explode s (String.length s - 1) []
```
