let rec traverse (f : 'a -> 'b option) (l : 'a list) : 'b list option =
  match l with
  | [] -> Some []
  | x :: xs ->
      (match f x with
       | None -> None
       | Some y -> traverse f xs >>= fun ys -> Some (y :: ys))