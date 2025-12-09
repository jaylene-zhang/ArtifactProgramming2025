```ocaml
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: 'a tree) (sc:'a tree -> 'r) (fc: unit -> 'r): 'r =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) -> match ls with
      |[] -> sc tree
      |hd::xs -> if hd = 0 then helper xs l sc fc
                 else if hd = 1 then helper xs r sc fc
                 else fc()
                
  in
  helper ls tree (fun x -> Some x) (fun() -> None)
```