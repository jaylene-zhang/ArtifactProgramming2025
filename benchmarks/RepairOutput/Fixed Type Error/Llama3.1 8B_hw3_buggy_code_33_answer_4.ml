```python
let rec add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z -> n2 (n1 z (fun z -> z)) (fun x -> n2 (n1 z (fun z -> z)) (fun z -> z))
```