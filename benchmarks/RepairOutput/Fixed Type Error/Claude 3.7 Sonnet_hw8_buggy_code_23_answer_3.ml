```ocaml
let rec take (n : int) (s : 'a stream) : 'a list =
  if n <= 0 then []
  else s.head :: (if n > 1 then take (n-1) (s.tail ()) else [])
```