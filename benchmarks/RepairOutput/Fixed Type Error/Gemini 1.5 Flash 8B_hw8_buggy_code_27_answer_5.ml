```ocaml
let take n s =
  let rec take_tr (n : int) (s : 'a stream) (acc : 'a list) : 'a list = 
    match n with
    | 0 -> acc
    | num ->
      let s' = s.tail () in
      take_tr (num - 1) s' (s.head :: acc)
  in
  take_tr n s []
```