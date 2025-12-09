(* Question 1: Tree Depth *)

let tree0 = Empty
let tree1 = Tree (Tree (Empty, 2, Empty), 1, Tree (Tree (Empty, 2, Empty), 1, Empty))


(* TODO: Write a good set of tests for tree depth. *)
let tree_depth_cps_tests: (int tree * int) list = [ 
  (tree0, 0); 
  (tree1, 3);
]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*)
let tree_depth_cps t = 
  raise NotImplemented


(* Question 2: Finding Subtrees *)

let tree0 = Empty 
let tree1 = Tree (Tree (Empty, 2, Empty), 1, Tree (Tree (Empty, 2, Empty), 1, Empty))
let tree2 = Tree (
    Tree (
      Empty,
      3,
      Tree (Tree (Empty, 5, Empty), 4, Empty)
    ),
    1,
    Tree (
      Tree (Empty, 2, Empty),
      1,
      Empty
    )
  )

    
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [ 
  (([1], tree0), None);
  (([1;1;2], tree1), Some Empty);
  (([1;3;4], tree2), Some (Tree (Empty, 5, Empty)))
]
;;

(* TODO: Implement a CPS style find_subtree_cont function.*)
let find_subtree_cps ls tree =
  let rec helper ls tree sc fc =
    raise NotImplemented
  in
  helper ls tree (fun() -> ()) (fun() -> ())


(* Question 3: Arithmetic Experssion Parser *)
(* TODO: Write a good set of tests for testing your parser. *)
let check_parser_tests : ((token list * float ) * float option) list = [
]
;;

(* TODO: Implement a CPS style parser function.*)
type ('r, 'a) parser_LN = token list -> (unit -> 'r) -> (token list -> 'a -> 'r) -> 'r
  
let parser_cps t =
  raise NotImplemented

let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)