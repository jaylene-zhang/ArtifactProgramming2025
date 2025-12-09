```ocaml
let find_subtree_cps ls tree =
  let rec helper (ls: int list) (tree: int tree) (sc: int tree -> 'r) (fc: unit -> 'r): 'r =
    match tree with
    | Empty -> fc ()
    | Tree (l, x, r) -> (
        match ls with
        | [] -> sc tree
        | y :: ys ->
            if y = x then helper ys l sc (fun () -> helper ys r sc fc)
            else fc ()
      )
  in
  helper ls tree (fun x -> Some x) (fun () -> None)
```