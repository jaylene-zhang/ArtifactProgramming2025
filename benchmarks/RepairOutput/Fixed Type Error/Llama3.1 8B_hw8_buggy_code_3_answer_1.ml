```hindley myfile stream 
let rec map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : ('c * 'd) stream =
  match s1 with { head = h1; tail = next1 } -> match s2 with { head = h2; tail = next2 } -> 
  unfold (f h1 h2) (next1 ()) (next2 ())
```