```hocaml
let to_int (n : int church) : int = 
  let rec helper a = match a with
    | s, z -> 0 + z s z
  in
  helper n
```