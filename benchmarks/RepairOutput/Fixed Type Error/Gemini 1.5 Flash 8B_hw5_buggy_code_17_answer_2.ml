```OCaml
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:int tree -> int option) (fc: unit -> int option) : int option =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |h::t-> if h = x then sc tree else helper t l sc fc
  in
  helper ls tree (fun(x) -> Some x) (fun() -> None)
```
