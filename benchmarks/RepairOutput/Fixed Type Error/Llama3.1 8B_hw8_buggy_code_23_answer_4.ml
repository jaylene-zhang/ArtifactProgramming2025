```hind```
let rec take (n : int) (s : 'a stream) : 'a list =
  if n <= 0 
  then []
  else s.head :: take (n-1) (s.tail ())