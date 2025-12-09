(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
let depth_tree = Tree (Empty, 1, (Tree (Empty, 9, Empty)))

let tree_depth_cps_tests: (int tree * int) list = [
    (* Your test cases go here *)
  (Empty, 0);
  (depth_tree, 2)
]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*)
let tree_depth_cps t = 
  let rec depth_cps t k =
    match t with
    | Empty -> k 0
    | Tree (l, _, r) ->
        depth_cps l (fun dcl ->
            depth_cps r (fun dcr ->
                k (1 + (max dcl dcr))))
  in depth_cps t (fun x -> x)
  (*raise NotImplemented*)


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let sub_tree = Tree (Tree (Tree (Empty, 2, Empty), 7, Tree (Empty, 6, Empty)), 1, (Tree (Empty, 9, Tree (Empty, 9, Empty))))
    
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
  (([7], sub_tree), None);
  (([1; 7; 2], sub_tree), Some Empty);
  (([1; 9], sub_tree), Some (Tree (Empty, 9, Empty)));
  (* Your test cases go here *)
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