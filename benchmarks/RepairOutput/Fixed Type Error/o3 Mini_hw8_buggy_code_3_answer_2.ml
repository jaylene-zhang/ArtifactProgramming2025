let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  map (fun (a, b) -> f a b) (zip s1 s2)