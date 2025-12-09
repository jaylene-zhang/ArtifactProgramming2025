`unfold` expects the first argument to be the input of type `'a`, but in the buggy code, it is `(s3)`, which is a pair of type `'a * 'b`. 

The fixed code should be:

```haskell
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream = 
  let s3 = zip s1 s2 in 
  unfold (fun () -> (f s3.head, s3.tail)) ()
```