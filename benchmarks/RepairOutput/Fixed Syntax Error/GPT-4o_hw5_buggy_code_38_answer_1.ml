```ocaml
(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
type 'a tree = 
  | Empty
  | Tree of 'a tree * 'a * 'a tree

let tree_depth_cps_tests: (int tree * int) list = [
  (Empty, 0);
  (Tree(Empty, 1, Tree(Empty, 0, Empty)), 2);
]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*)
let tree_depth_cps t = 
  let depth_helper t return =
    match t with
    | Empty -> return 0
    | Tree (l, _, r) -> 
        depth_helper l (fun dl -> 
          depth_helper r (fun dr -> return (1 + max dl dr)))
  in
  depth_helper t (fun x -> x)


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
    (* Your test cases go here *)
]
;;

(* TODO: Implement a CPS style find_subtree_cps function.*)
let find_subtree_cps ls tree =
  let rec helper ls tree sc fc =
    match ls, tree with
    | [], _ -> sc (Some tree)
    | _, Empty -> fc ()
    | x::xs, Tree (l, v, r) ->
        if x = v then helper xs l (fun res -> sc res) (fun () -> helper xs r sc fc)
        else helper ls l (fun res -> sc res) (fun () -> helper ls r sc fc)
  in
  helper ls tree (fun res -> res) (fun () -> None)


(* Question 3: Arithmetic Expression Parser *)
(* TODO: Write a good set of tests for testing your parser. *)
type token = 
  | Num of float
  | Plus
  | Minus
  | Times
  | Div
  | LParen
  | RParen

let check_parser_tests : ((token list * float) * float option) list = [
]
;;

(* TODO: Implement a CPS style parser function.*)
type ('r, 'a) parser_LN = token list -> (unit -> 'r) -> (token list -> 'a -> 'r) -> 'r
  
let parser_cps t =
  raise NotImplemented

let eval expr value = raise NotImplemented

let check_parser t v = match parser_cps t with
  | exception _ -> None
  | r -> Some (eval r v)
```