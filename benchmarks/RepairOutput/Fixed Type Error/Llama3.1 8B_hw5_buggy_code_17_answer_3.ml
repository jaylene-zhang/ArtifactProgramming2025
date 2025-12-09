```haskell
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:'a option -> 'r) (fc: unit->'r): 'r =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |x::xs-> (let opt = helper xs l sc fc in sc opt)
                
  in
  helper ls tree (fun(x) -> Some x) (fun() -> None)
```