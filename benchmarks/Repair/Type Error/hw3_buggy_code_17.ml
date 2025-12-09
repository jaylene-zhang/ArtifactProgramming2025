
(* TODO: Implement
   Although the input n is of type int church, please do not be confused. This is due to typechecking reasons, and for
   your purposes, you could pretend n is of type 'b church just like in the other problems.
*)
let to_int (n : int church) : int = 
  let rec helper a = match a with
    | (s, z) -> 0
  in
  helper n
