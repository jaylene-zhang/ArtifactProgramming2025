```
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 0 -> s
  | _ -> 
    let tail = s.tail () in
    { head = tail.head; 
      tail = drop (n-1) tail }
```