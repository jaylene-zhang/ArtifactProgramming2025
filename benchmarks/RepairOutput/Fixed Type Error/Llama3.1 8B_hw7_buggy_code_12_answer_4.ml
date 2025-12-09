```haskell
let string_implodeantz (l : char list) : string =
  let c = List.map (String.make 1) l in
  String.concat ""
```