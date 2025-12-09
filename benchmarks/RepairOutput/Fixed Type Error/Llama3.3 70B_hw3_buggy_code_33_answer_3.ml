```
let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z s -> n2 (n1 z s) s
```