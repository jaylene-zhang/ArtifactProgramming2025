```ocaml
(* Q1: 5 points *)
let f1 = fun x -> if x >= 0 then Some x else None
let traverse_tests : (((int -> int option) * int list) * int list option) list =
  [((f1,[0;-1]),None);((f1,[0;1]),Some [0;1])]
  
let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option = 
  match l with 
  | [] -> Some []
  | h :: t -> 
      match f h with
      | None -> None
      | Some x -> 
          (match traverse f t with
           | None -> None
           | Some rest -> Some (x :: rest))
```