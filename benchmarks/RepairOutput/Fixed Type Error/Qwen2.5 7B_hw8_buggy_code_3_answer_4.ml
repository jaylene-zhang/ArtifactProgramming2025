```ocaml
(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  let m1 = zip s1 s2 in 
  map f m1
```

The provided code is actually correct and does not contain the type error indicated by the compiler. The `zip` function returns a stream of tuples, and `map` can then correctly apply a function to each tuple, producing a stream of results. Therefore, no changes are needed to fix the type error.