```exception Subtraction of string 

let rec sub (n1 : 'b church) (n2 : 'b church) : 'b church =
  match n2 with
  | zero -> n1
  | one -> n1
  | s -> sub (fun z -> sub n1 z s) (church rec s)
```