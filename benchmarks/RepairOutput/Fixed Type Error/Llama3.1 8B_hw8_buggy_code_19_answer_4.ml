```bred
let rec drop (n : int) (s : 'a stream) : 'a stream =
  match n with 
  | 0 -> s
  | _ -> let s' = drop (n-1) s in fun () -> s'.tail
```