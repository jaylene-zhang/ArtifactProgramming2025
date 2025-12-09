(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
let tree_depth_cps_tests: (int tree * int) list = [(Empty,0);
                                                   (Tree(Empty,2,Tree(Empty,1,Empty)),2)
                                                   
    (* Your test cases go here *)
                                                  ]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*)
let rec depth_helper (t : 'a tree) (return : int -> int) : int = 
  match t with
  | Empty -> return 0
  | Tree (l, _, r) -> max (depth_helper l (fun r -> return (r+1)))
                        (depth_helper r (fun r -> return (r+1)))
  
let tree_depth_cps t = depth_helper t (fun x -> x)


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = 
  [
    (* Your test cases go here *) 
    (([1;3],Tree(Tree(Empty,2,Empty),1,(Tree(Tree(Empty,4,Empty),3,Empty)))),
     (Some (Tree(Empty, 4,Empty)))
    ) ;
    
    (([1;2],Tree(Empty,1,(Tree(Empty,2,Tree(Empty,3,Empty))))),
     (Some Empty)
    ) 
  ]
;;

(* TODO: Implement a CPS style find_subtree_cont function.*)
let find_subtree_cps (ls : 'a list) (tree : 'a tree) : 'a tree option=
  let rec helper (list: 'a list) (atree: 'a tree) success fail =
    match list with
    | [] -> success atree
    | y :: ys -> 
        match atree with
        | Empty when list !=[] -> fail ()
        | Empty -> success atree 
        | Tree(l,x,r) -> 
            if y = x then helper ys l success (fun () -> helper ys r success fail)
            else fail()        
  in
  helper ls tree (fun x -> Some x) (fun () -> (None))  


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