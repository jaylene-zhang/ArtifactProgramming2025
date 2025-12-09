let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  let s3 = zip s1 s2 in
  unfold (fun s ->
    let (x, y) = s.head in
    (f x y, s.tail ())
  ) s3