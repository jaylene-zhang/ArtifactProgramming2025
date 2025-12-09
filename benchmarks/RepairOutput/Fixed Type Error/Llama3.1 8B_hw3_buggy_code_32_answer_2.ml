```diff
let mult (n1 : 'b church) (n2 : 'b church) : 'b church = fun z s-> n1 (n2 z s) s
```