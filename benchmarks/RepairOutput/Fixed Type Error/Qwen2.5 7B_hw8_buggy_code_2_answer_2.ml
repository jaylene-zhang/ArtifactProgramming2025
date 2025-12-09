```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun (h, t) -> let s3 = { head = h; tail = (fun () -> unfold (fun (s3) -> (f s3.head, s3.tail ()) (f h)) } in (s3.head, s3.tail ())) (h, t)
```
The issue was that the `unfold` function expected a tuple of the same type as the stream elements, but the code was not correctly forming that tuple. By destructuring the `s3` and unfolding the stream again, the correct type is achieved.