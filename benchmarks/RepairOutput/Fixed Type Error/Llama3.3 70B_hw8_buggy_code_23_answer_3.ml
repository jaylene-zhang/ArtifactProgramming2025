```ocaml
let rec take (n : int) (s : 'a stream) : 'a list =
  if n <= 0 then []
  else if n = 1 then [s.head]
  else s.head :: take (n - 1) (s.tail ())
```