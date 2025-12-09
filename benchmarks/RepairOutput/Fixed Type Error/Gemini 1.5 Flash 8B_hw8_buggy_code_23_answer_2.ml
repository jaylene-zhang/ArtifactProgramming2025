```ocaml
(* TODO: Q1a *)
let rec take (n : int) (s : 'a stream) : 'a list =
  match n with
  | 0 -> []
  | _ -> if s.head = [] then [] else s.head :: (take (n - 1) (s.tail ()))
```
