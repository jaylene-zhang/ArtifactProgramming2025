```ocaml
let rec take (n : int) (s : 'a stream) : 'a list =
  let rec aux (n : int) (acc : 'a list) (s : 'a stream) : 'a list =
    if n = 0 then acc
    else aux (n - 1) (s.head :: acc) (s.tail ())
  in
  aux n [] s
```