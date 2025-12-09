```ocaml
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: 'a tree) (sc:'a tree-> 'r) (fc: unit->'r): 'r =
    match tree with
    |Empty -> fc()
    |Tree(l, v, r) -> match ls with
      |[] -> sc tree
      |h::xs -> if h = v then helper xs l sc fc
                else helper xs r sc fc
                
  in
  helper ls tree (fun x -> Some x) (fun() -> None)
```