let find_subtree_cps ls tree =
  let rec helper (ls : int list) (tree : int tree) (sc : int -> 'r) (fc : unit -> 'r) : int option =
    match tree with
    | Empty -> fc ()
    | Tree (l, x, r) ->
       match ls with
       | [] -> sc x
       | _ :: xs -> helper xs l sc (fun () -> helper xs r sc fc)
  in
  helper ls tree (fun x -> Some x) (fun () -> None)