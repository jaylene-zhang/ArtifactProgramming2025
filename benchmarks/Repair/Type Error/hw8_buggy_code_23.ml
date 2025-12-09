(* TODO: Q1a *)
let rec take (n : int) (s : 'a stream) : 'a list =
  [s.head;(s.tail ())]
