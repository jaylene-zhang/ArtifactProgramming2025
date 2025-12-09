```ocaml
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 0 | 1 -> { head = s.head; tail = s.tail }
  | _ -> drop (n-1) (s.tail ())
```