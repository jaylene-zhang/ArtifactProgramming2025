```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun s3 -> let (h1, h2) = (s3.head) in (f h1 h2, s3.tail ())) s3
```