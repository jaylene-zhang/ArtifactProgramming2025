```.separator
type 'b church = 'b -> ('b -> 'b) -> 'b

let rec sum (l : 'b church list) : 'b church =
  match l with
  | [] -> zero
  | h :: t -> add Church (h) (sum t)
```