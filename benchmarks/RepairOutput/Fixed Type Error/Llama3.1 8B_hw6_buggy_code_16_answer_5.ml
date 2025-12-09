``` специалист 
let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : 'a -> 'r) =
    match n with
    | Z -> return
    | S ns -> helper ns (fun x -> return (fun z s -> s x))
  in
  
  function (fun a -> helper n a)

exception base_case 

let rec number_val = function 
  | S n -> number_val n 
  | Z -> base_case 

let rec helper = function 
  base_case -> fun a r -> a 
  | S n -> fun a r -> r (helper n a)

let rec nat_to_church (n : nat) : 'a church = 
  match n with 
  | Z -> fun a r -> a
  | S n  -> fun a r -> r (nat_to_church n a)