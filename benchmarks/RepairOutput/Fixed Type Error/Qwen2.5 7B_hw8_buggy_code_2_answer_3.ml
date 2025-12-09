```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun (h1, h2) -> let s3 = zip s1 s2 in (f h1 h2, fun () -> unfold (fun (h1, h2) -> let s3 = zip s1 s2 in (f h1 h2, fun () -> ())) (s1.tail ())))
  (f s1.head s2.head)
```