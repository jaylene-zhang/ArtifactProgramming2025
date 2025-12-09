```ocaml
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:'a tree -> 'r) (fc: unit -> 'r): 'a option =
    match tree with
    | Empty -> fc ()
    | Tree (l, x, r) -> 
      match ls with
      | [] -> fc ()
      | x::xs -> 
        let r_option = helper xs l sc fc in
        match r_option with
        | Some y -> Some y
        | None -> helper xs r sc fc
  in
  helper ls tree (fun(x) -> Some x) (fun() -> None)
```