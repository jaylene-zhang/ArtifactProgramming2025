```ocaml
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree:'a tree) (sc:'a tree-> 'r) (fc: unit->'r): 'a option =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |x::xs-> helper xs l (fun(x) -> Some x) (fun() -> helper xs r (fun(x) -> Some x) (fc))
                
  in
  helper ls tree (fun(x) -> Some x) (fun() -> None)
```