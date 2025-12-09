``` ocaml
let map2 (f : ('a -> 'b -> 'c)) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  let (x, y) = s3 in
  unfold (fun () -> (f x y, s1.tail ()).head, s3.tail ()) ()
```