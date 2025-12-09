```haskell
let string_explode (s : string) : char list = 
  let rec explode s n =
    if n > 0 then explode s (pred n) (String.get s n :: acc)
    else acc
  in 
  explode s (String.length max_int) []
```