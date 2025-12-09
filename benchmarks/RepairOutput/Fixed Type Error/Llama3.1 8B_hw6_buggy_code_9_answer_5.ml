\
let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option =
  match l with
  | [] -> Some []
  | x :: xs ->
      (match f x with
       | None -> None
       | Some y -> (match traverse f xs with | None -> None | Some ys -> Some (y :: ys)))