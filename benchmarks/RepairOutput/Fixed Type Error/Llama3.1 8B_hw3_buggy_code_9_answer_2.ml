```emacs
let add (n1 : 'b -> 'a -> 'a) (n2 : 'b -> 'a -> 'a) : 'b -> 'a -> 'a = 
  fun ('b -> 'a -> 'a) s -> fun ('b -> 'a -> 'a) -> s n1 n2
```