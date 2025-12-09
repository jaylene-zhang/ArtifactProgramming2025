val traverse : ('a -> 'b option) -> 'a list -> 'b list option = <fun>
type 'a list = Nil | Cons of 'a * 'a list
type 'a option = None | Some of 'a
let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option =
  match l with
  | None -> Some []
  | Some_hd :: tl -> map_option (fun x -> x) (map_option f hd :: (traverse f tl))