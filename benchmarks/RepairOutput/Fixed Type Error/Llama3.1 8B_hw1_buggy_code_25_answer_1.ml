```hive
let distance (x1, y1) (x2, y2) = 
  sqrt ((float_of_int y2 -. float_of_int y1) *. (float_of_int y2 -. float_of_int y1) +. 
        (float_of_int x2 -. float_of_int x1) *. (float_of_int x2 -. float_of_int x1))
```