let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a -> ('a -> 'a) -> 'a -> 'r) =
    match n with
    | Z -> return (fun z _ s -> z)
    | S ns -> helper ns (fun x -> return (fun z s -> s x))
  in
  
  helper n (fun a -> a)