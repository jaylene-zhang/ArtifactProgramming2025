let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a church -> 'r) =
    match n with
    | Z -> fun z s -> z
    | S ns -> fun z s -> s (helper ns (fun x -> fun z' s' -> s' x))
  in
  helper n (fun r -> r)
;;