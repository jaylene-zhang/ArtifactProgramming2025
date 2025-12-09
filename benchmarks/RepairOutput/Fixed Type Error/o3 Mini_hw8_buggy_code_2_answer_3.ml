let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  let zipped = zip s1 s2 in
  unfold (fun s ->
    let (a, b) = s.head in
    (f a b, s.tail ())
  ) zipped