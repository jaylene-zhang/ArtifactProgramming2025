```ocaml
let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a church) =
    match n with
    | Z -> return (fun z s -> z)
    | S ns -> helper ns (fun x -> fun z s -> s (return z s))
  in
  
  helper n (fun z s -> z)
;;
```