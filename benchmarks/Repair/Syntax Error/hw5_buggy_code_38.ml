(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
let tree_depth_cps_tests: (int tree * int) list = [
  (Empty, 0);
  ((Tree(Empty, 1, Tree(Empty, 0, Empty))), 2);
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
    | Tree (l, _, r) -> max (depth_helper l (fun x -> x + 1)) (depth_helper r (fun x -> x + 1)) in
  depth_helper t fun (x -> x)


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
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