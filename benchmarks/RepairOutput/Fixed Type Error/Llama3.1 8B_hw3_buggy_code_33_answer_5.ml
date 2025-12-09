```hack
let add (n1 : 'a church) (n2 : 'a church) : 'a church =
  fun z -> n1(z (n2 z (fun x-> x))) (fun z -> z)
```