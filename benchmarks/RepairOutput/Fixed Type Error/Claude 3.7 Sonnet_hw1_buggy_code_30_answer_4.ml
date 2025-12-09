```ocaml
let lucas_helper n =
  let rec lucas_helper2 n n1 n2 = 
    if n = 0 then n1 else
    if n = 1 then n2 else
      lucas_helper2 (n-1) (n2) (n1+n2)
  in 
  lucas_helper2 n 2 1 
  
let lucas n =
  if n = 0 then 2 else
  if n = 1 then 1 else
  (lucas_helper (n-1)) + (lucas_helper (n-2))
```