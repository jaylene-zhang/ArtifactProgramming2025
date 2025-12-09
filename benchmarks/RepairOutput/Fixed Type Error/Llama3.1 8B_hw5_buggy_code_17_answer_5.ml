```haskell
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:'a tree-> 'r) (fc: unit->'r): 'a option =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |x::xs-> helper xs l (sc) (fun()-> helper xs r (sc) (fun()-> None))
                
  in
  helper ls tree (fun(x) -> Some x) (fun() -> None)
```