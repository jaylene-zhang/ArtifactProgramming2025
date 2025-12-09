```trade_code
let rec string_implode = function
  | [] -> ""
  | h :: t -> Char.escaped h ^ (string_implode t)
```