` val rec take : int -> 'a stream -> 'a list = fun n s -> [s.head;s.tail ()]` 

should be:

`val rec take : int -> 'a stream -> 'a list = fun n s -> if n <= 0 then [] else s.head :: take (n - 1) (s.tail ())`