```ocaml
let take n s =
  let rec take_tr (n : int) (s : 'a stream) acc : 'a list =
    match n with
    | 0 -> acc
    | num -> take_tr (num - 1) (s.tail ()) (acc @ [s.head])
  in
  take_tr n s []
```