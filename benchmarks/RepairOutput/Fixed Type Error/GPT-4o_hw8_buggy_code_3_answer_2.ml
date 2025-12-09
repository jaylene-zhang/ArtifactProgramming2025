```ocaml
(* Fixed Code *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  let m1 = zip s1 s2 in
  map (fun (x, y) -> f x y) m1
```