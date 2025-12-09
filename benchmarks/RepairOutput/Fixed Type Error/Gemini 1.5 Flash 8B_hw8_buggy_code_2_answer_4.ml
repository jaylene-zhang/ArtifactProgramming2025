```OCaml
(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun pair -> (f pair.fst pair.snd, (fun () -> pair.tail()))) (f (fst s3.head) (snd s3.head))
```
