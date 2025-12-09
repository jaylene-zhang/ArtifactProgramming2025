(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
let tree_depth_cps_tests: (int tree * int) list = [
    (* Your test cases go here *)
  (Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))),3);
  (Empty,0);
]
;;

let rec tree_depth t = match t with
  | Empty -> 0
  | Tree (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(* TODO: Implement a CPS style tree_depth_cps function.*)
let tree_depth_cps t = 
  let rec tree_depth_cps_helper (t : 'a tree) (return : int -> int) : int = 
    match t with
    | Empty -> return 0
    | Tree (l,_,r) -> tree_depth_cps_helper l (fun l_depth -> 
        tree_depth_cps_helper r (fun r_depth ->
            return (1+ max r_depth l_depth)))
  in
  tree_depth_cps_helper t (fun x->x)


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
    (* Your test cases go here *)
  (([2;3],(Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))))),
   Some (Empty));
  (([],(Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))))),Some
     (Tree (Tree (Empty, 1, Empty), 2, Tree (Empty, 3, Tree (Empty, 4, Empty)))));
  (([3],(Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))))),None)
]
;;

let rec find_subtree ls tree : 'a tree option= 
  match tree with
  | Empty -> None
  | Tree (l,v,r) -> (match ls with
      | [p] -> if p = v then (if l = Empty then (
          if r = Empty then None else Some r) else Some l) else None
      | t :: ts -> if find_subtree ts l = None then find_subtree ts r
          else None
      | [] -> Some tree
            
    )

(* TODO: Implement a CPS style find_subtree_cont function.*)
let find_subtree_cps ls tree =
  let rec helper ls tree return (fail : unit -> 'a tree option) : 'a tree option = 
    match tree with
    | Empty -> fail ()
    | Tree (l,v,r) -> ( match ls with
        | [p] -> if p = v then return (Some l) else fail ()
        | t :: ts -> helper ts l return (fun () -> 
            helper ts r return fail)
        | [] -> return (Some tree)
        
      )
  in
  helper ls tree (fun (x) -> (x)) (fun () -> None)


(* Question 3: Arithmetic Experssion Parser *)
(* TODO: Write a good set of tests for testing your parser. *)
let check_parser_tests : ((token list * float ) * float option) list = [
]
;;

(* TODO: Implement a CPS style parser function.*)
type ('r, 'a) parser_LN = token list -> (unit -> 'r) -> (token list -> 'a -> 'r) -> 'r
  
  
let L1 tokens=
  match tokens with
  | [t] -> Some (factor tokens)
  | t1 :: t2 :: ts -> if t2 = POW
      then (
        match factor tokens with
        | Some e1 -> (
            match factor ts with 
            | Some e2 -> Some (Pow(e1,e2))
            | None -> None
          )
        | None -> None
      )
      else factor tokens
  | _ -> None
  
    
let factor tokens =
  match tokens with
  | [t] -> (
      match t with
      |FLOAT f -> Some(Const f)
      |VAR -> Some Var
      |RPAREN -> Some()
      | _ -> None
    )
  | t1 :: t2 :: ts -> (
      match t1 with 
      | FLOAT f -> Some (Const f)
      | VAR -> Some Var
      | LPAREN -> Some (Plus(0,expr (t2::ts)))
      | RPAREN -> expr (t2::ts)
      | _ -> None
    )
  | _ -> None
      
let rec L2 tokens : exp option= 
  match tokens with 
  | [t] -> L1 tokens
  | t1 :: t2 :: ts -> if t2=TIMES
      then (
        match L1 tokens with
        | Some e1 -> (
            match L2 ts with
            | Some e2 -> Some (Times(e1,e2))
            | None -> None
          )
        | None -> None
      )
      else L1 tokens
  | _ -> None
    
let rec expr tokens : exp option= 
  match tokens with 
  | [t] -> L2 tokens
  | t1 :: t2 :: ts -> if t2=PLUS
      then (
        match L2 tokens with
        | Some e1 -> (
            match expr ts with
            | Some e2 -> Some (Plus(e1,e2))
            | None -> None
          )
        | None -> None
      )
      else L2 tokens
  | _ -> None
  

let parser_cps t : exp option=
  raise NotImplemented

let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)