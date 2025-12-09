```ocaml
let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a -> 'a church -> 'r) (r : 'a) =
    match n with
    | Z -> return r (fun z s -> z)
    | S ns -> helper ns return (r s)
  in
  
  helper n return (fun _ s -> s (fun z s -> z))
;;
```