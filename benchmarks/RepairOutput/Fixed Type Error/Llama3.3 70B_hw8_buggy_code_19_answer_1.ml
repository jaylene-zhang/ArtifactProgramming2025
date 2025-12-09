```
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 0 -> s
  | 1 -> {head = (s.tail ()) ; tail = fun () -> s.tail ()}
  | _ -> drop (n-1) (s)
```