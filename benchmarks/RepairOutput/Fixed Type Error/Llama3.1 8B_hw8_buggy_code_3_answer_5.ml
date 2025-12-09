```haskell
let rec map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  match s1 with
  | {head = x; tail = t;} ->
     match s2 with
     | {head = y; tail = u;} -> 
         map (fun z -> f x z) (zip t u)
     | _ -> empty_stream
```