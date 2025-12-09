let find_subtree_cps ls tree =
  let rec helper (ls : int list) (tree : int tree)
                 (sc : int tree -> int tree option)
                 (fc : unit -> int tree option) : int tree option =
    match tree with
    | Empty -> fc ()
    | Tree (l, x, r) ->
      match ls with
      | [] -> sc tree
      | d :: ds -> helper ds l sc (fun () -> helper ds r sc fc)
  in
  helper ls tree (fun x -> Some x) (fun () -> None)