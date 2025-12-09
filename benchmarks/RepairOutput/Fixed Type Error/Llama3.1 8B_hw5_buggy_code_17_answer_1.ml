```haskell
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:'a tree-> 'r) (fc: unit->'r): 'a option =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |x::xs-> helper xs r (sc(l)) (fun()-> helper xs l (sc(r)) (fun()-> (fc())))
                
  in
  helper ls tree (fun(x) -> Some x) (fun() -> None)
```