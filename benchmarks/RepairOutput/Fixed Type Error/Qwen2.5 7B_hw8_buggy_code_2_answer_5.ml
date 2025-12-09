```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun (x, y) -> (f x.y, fun () -> map2 f s1.tail s2.tail)) (f (s3.head).head, fun () -> s3.tail ())
```