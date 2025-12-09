Here is the fixed code:

```ocaml
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:unit -> 'a option) (fc: unit->'a option): 'a option =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |x::xs-> helper xs l sc (fun()-> helper xs r sc fc)
                
  in
  helper ls tree (fun() -> Some tree) (fun() -> None)
```