```diff
- let rec take (n : int) (s : 'a stream) : 'a list =
+ let rec take (n : int) (s : 'a stream) : (('a list) ref) =
  if n <= 0 then []
  else (s.head :: (!s.tail ()); take (n-1) s)
```