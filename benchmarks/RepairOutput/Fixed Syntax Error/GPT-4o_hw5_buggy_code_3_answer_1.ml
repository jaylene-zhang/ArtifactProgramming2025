```ocaml
(* Question 1: Tree Depth *)
(* TODO: Write a good set of tests for tree depth. *)
type 'a tree = 
  | Empty
  | Tree of 'a tree * 'a * 'a tree

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
  tree_depth_cps_helper t (fun x -> x)


(* Question 2: Finding Subtrees *)
(* TODO: Write a good set of tests for finding subtrees. *)
let find_subtree_cps_tests : ((int list * int tree) * int tree option) list = [
  (* Your test cases go here *)
  (([2;3],(Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))))),
   Some (Tree(Empty,3,Tree(Empty,4,Empty))));
  (([],(Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))))),Some
     (Tree (Tree (Empty, 1, Empty), 2, Tree (Empty, 3, Tree (Empty, 4, Empty)))));
  (([3],(Tree(Tree(Empty,1,Empty),2,Tree(Empty,3,Tree(Empty,4,Empty))))),None)
]
;;

let rec find_subtree ls tree : 'a tree option= 
  match tree with
  | Empty -> None
  | Tree (l,v,r) -> (match ls with
      | [p] -> if p = v then Some tree else None
      | t :: ts -> if t = v then (
          match find_subtree ts l with
          | Some subtree -> Some subtree
          | None -> find_subtree ts r
        ) else None
      | [] -> Some tree
    )

(* TODO: Implement a CPS style find_subtree_cont function.*)
let find_subtree_cps ls tree =
  let rec helper ls tree return (fail : unit -> 'a tree option) : 'a tree option = 
    match tree with
    | Empty -> fail ()
    | Tree (l,v,r) -> (match ls with
        | [p] -> if p = v then return (Some tree) else fail ()
        | t :: ts -> if t = v then helper ts l return (fun () -> 
            helper ts r return fail)
          else fail ()
        | [] -> return (Some tree)
      )
  in
  helper ls tree (fun x -> x) (fun () -> None)


(* Question 3: Arithmetic Expression Parser *)
(* TODO: Write a good set of tests for testing your parser. *)
type token = 
  | FLOAT of float
  | VAR
  | LPAREN
  | RPAREN
  | PLUS
  | TIMES
  | POW

type exp = 
  | Const of float
  | Var
  | Plus of exp * exp
  | Times of exp * exp
  | Pow of exp * exp

let check_parser_tests : ((token list * float ) * float option) list = [
]
;;

(* TODO: Implement a CPS style parser function.*)
type ('r, 'a) parser_LN = token list -> (unit -> 'r) -> (token list -> 'a -> 'r) -> 'r

let factor tokens =
  match tokens with
  | FLOAT f :: ts -> Some (Const f, ts)
  | VAR :: ts -> Some (Var, ts)
  | LPAREN :: ts -> (
      match expr ts with
      | Some (e, RPAREN :: rest) -> Some (e, rest)
      | _ -> None
    )
  | _ -> None

let rec L1 tokens =
  match factor tokens with
  | Some (e1, POW :: ts) -> (
      match factor ts with
      | Some (e2, rest) -> Some (Pow (e1, e2), rest)
      | None -> None
    )
  | res -> res

and L2 tokens =
  match L1 tokens with
  | Some (e1, TIMES :: ts) -> (
      match L2 ts with
      | Some (e2, rest) -> Some (Times (e1, e2), rest)
      | None -> None
    )
  | res -> res

and expr tokens =
  match L2 tokens with
  | Some (e1, PLUS :: ts) -> (
      match expr ts with
      | Some (e2, rest) -> Some (Plus (e1, e2), rest)
      | None -> None
    )
  | res -> res

let parser_cps tokens =
  match expr tokens with
  | Some (e, []) -> Some e
  | _ -> None

let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)
```