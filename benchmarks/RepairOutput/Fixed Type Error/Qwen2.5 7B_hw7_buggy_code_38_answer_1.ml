```ocaml
let string_explode (s : string) : char list = 
  let rec explode s n acc= 
    if n > 0 then explode s (n-1) (String.get s n)::acc
    else acc
  in 
  explode s (String.length s - 1) []
```