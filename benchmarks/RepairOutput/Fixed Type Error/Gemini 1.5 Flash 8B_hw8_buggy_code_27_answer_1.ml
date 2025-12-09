```ocaml
let take n s =
  let rec take_tr (n : int) (s : 'a stream) acc : 'a list = 
    match n with
    | 0 -> acc
    | num -> 
      let hd = s.head in
      let tl = s.tail () in
      take_tr (num - 1) tl (hd :: acc)
  in
  take_tr n s []
```