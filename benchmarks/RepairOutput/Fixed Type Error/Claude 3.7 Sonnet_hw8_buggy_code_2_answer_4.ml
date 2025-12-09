```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  let apply_f (a, b) = f a b in
  map apply_f s3
```