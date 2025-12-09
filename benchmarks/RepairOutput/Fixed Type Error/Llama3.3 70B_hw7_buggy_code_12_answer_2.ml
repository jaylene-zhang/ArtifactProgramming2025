Here is the fixed code:
```
let string_implode (l : char list) : string =
  let c = List.map (Char. String.of_char) l in
  List.fold_left (fun x y -> x ^ y) c ""
```