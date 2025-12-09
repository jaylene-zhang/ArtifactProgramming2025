let rec nat_to_church (n : nat) : 'a church =
  let rec helper (n : nat) (continue : 'a church -> 'a church) =
    match n with
    | Z -> continue (fun z s -> z)
    | S ns -> helper ns (fun x -> continue (fun z s -> s (x z s)))
  in
  helper n (fun r -> r)
;;