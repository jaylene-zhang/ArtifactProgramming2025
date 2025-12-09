```ocaml
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  let m1 = zip s1 s2 in 
  map f m1
```

The original code is correct and should work as expected. The error message suggests that there might be an issue with the types of the streams, but the given implementation of `map2` is sound. If there is an issue, it is likely in the context where `map2` is being used, not in the definition itself.