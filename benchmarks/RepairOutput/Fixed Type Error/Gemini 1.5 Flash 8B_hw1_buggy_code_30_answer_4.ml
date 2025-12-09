```ocaml
let lucas_helper n =
  let rec lucas_helper2 n n1 n2 =
    if n = 0 then n1 else
    if n = 1 then n2 else
      lucas_helper2 (n - 1) n2 (n1 + n2)
  in
  let result = lucas_helper2 n 2 1 in
  result

let lucas n =
  lucas_helper (n - 1) + lucas_helper (n - 2)
```
