Here is the fixed code:

```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun (s3) -> (f s3.head.fst s3.head.snd, s3.tail ())) s3
```