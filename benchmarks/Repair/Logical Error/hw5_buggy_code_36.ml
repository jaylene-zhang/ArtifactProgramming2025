(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
let tree_depth_cps_tests: (int tree * int) list = [
  (Empty, 0);
  (Tree (Empty, 1, Tree (Empty, 0, Empty)), 2)
]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*) 
let tree_depth_cps t = 
  let rec depth_helper (t : 'a tree) (return : int -> int) : int =
    match t with
    | Empty -> return 0
    | Tree (l, _, r) ->
        depth_helper l (fun depth_l ->
            depth_helper r (fun depth_r ->
                return (1 + (max depth_l depth_r))))
  in depth_helper t (fun d -> d)

(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *) 
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
    (* Your test cases go here *)
  (([1], Empty), None);
  (([2; 3; 4], Tree( Tree (Empty, 2, Tree (Empty, 4, Empty)), 3, Empty)), None);
  (([5;5], Tree (Tree (Tree (Empty, 1, Empty), 5, Tree( Empty, 2, Empty)),
                 5, Empty)), Some (Tree (Empty, 1, Empty)));
  (([9], Tree (Empty, 1, Empty)), None );
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