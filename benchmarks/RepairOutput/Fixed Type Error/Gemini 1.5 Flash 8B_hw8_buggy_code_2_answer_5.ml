```OCaml
(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in
  unfold (fun x -> (f x.head (fst x.tail) ), x.tail) s3
```
