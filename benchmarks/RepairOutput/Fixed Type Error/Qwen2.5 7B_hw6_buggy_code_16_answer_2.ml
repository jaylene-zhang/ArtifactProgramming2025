let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a church) =
    match n with
    | Z -> return (fun z s -> z)
    | S ns -> helper ns (return (fun x -> (fun z s -> s x)))
  in
  
  helper n (fun r -> r)
;;