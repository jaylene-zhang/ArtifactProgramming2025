```ocaml
let take n s =
  let rec take_tr (n : int) (s : 'a stream) (acc : 'a list) : 'a list =
    match n with
    | 0 -> acc
    | num ->
        let next_s = s.tail () in
        take_tr (num - 1) next_s (acc @ [s.head])
  in
  take_tr n s []
```
