let take n s = 
  let rec take_tr (n : int) (s : 'a stream) acc : 'a list = 
    match n with
    | 0 -> acc 
    | num -> take_tr (num-1) (s.tail ()) (s.head :: acc)
  in
  List.rev (take_tr n s [])