```haskell
let rec nat_to_church (n : nat) : 'a church = 
  let rec helper (n : nat) (return : ('a -> 'a -> 'a) -> 'r) : ('a -> ('a -> 'a) -> 'a) = 
    match n with
    | Z -> return
    | S ns -> helper ns (fun x y -> return x y)
  in
  
  helper n (fun r -> r)
;;
```