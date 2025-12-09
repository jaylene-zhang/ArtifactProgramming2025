```ocaml
let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a) =
    match n with
    | Z -> return
    | S ns -> helper ns (fun z s -> s (helper ns return z s))
  in
  
  helper n (fun z s -> z)
;;
```