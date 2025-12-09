(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
let tree_depth_cps_tests: (int tree * int) list = [
    (* Your test cases go here *)
  ((Tree(Tree(Tree(Empty, 1, Empty), 2, Empty), 5, Empty)), 3);
  ((Tree(Empty, 5, Empty)), 1);
  (Empty, 0);
  ((Tree(Empty, 5, Tree(Empty, 6, Empty))), 2); 
  
]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*)
let tree_depth_cps t =
  let rec go t (return: int -> 'r): 'r = match t with
    |Empty -> return 0
    |Tree (l, _ , r) -> go l (fun left -> 
        go r (fun right -> 
            return (1 + max left right))) 
  in
  go t (fun x -> x) 
  


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
  (([1], Empty),None);
  (([5], Tree(Empty, 5, Empty)), Some(Empty));
  ((([5], (Tree((Tree(Empty, 4, Empty)), 5 , Tree((Empty, 6, Empty))))), Some(Tree(Empty, 4, Empty))));
    (* Your test cases go here *)
]


(* TODO: Implement a CPS style find_subtree_cont function.*)
let find_subtree_cps ls tree =
  let rec helper (ls:int list) (tree: int tree) (sc:'a tree-> 'r) (fc: unit->'r): 'r =
    match tree with
    |Empty -> fc()
    |Tree(l, x, r) ->  match ls with
      |[]-> fc()
      |x::xs-> helper xs l (sc) (fun()-> helper xs r (sc) (fc))
                
  in
  helper ls tree (fun(x) -> Some(x)) (fun() -> None)


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