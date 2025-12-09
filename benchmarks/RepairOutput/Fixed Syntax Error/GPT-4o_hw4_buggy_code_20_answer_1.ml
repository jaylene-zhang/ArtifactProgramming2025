```ocaml
(** Question 1 *)

(* TODO: Add test cases. *)
let collect_variables_tests : (formula * Variable_set.t) list = [ 
  (parse_formula "x",Variable_set.singleton "x");
  (parse_formula "(x&y)",Variable_set.singleton "x"
                         |> Variable_set.add "y");
  (parse_formula "~(a|(b&~c)&c)",Variable_set.singleton "a"
                                 |> Variable_set.add "b"
                                 |> Variable_set.add "c"); 
]

(* TODO: Implement the function. *) 

let collect_variables (formula : formula) : Variable_set.t = 
  let rec go (formula : formula) (set:Variable_set.t): Variable_set.t =
    match formula with
    | Variable a -> Variable_set.add a set
    | Conjunction (a,b) | Disjunction (a,b) -> go a (go b set)
    | Negation a -> go a set
  in
  go formula Variable_set.empty
    
(** Question 2 *)

(* TODO: Add test cases. *)
let eval_success_tests : ((truth_assignment * formula) * bool) list = [ 
  ((Variable_map.singleton "x" true
    |> Variable_map.add "y" false,parse_formula "(x|y)&x"),true); 
  ((Variable_map.singleton "x" true,parse_formula "x&~x"),false);
  ((Variable_map.singleton "x" true
    |> Variable_map.add "y" false
    |> Variable_map.add "z" true,parse_formula "~x|z|~y"),true); 
]

(* TODO: Add test cases. *)
let eval_failure_tests : ((truth_assignment * formula) * exn) list = [ 
  ((Variable_map.singleton "x" true,parse_formula "x&y"),Unassigned_variable "y");
]

(* TODO: Implement the function. *)
let eval (state : truth_assignment) (formula : formula) : bool =
  let rec go state formula =
    match formula with
    | Variable a -> (match Variable_map.find_opt a state with
        | None -> raise (Unassigned_variable a)
        | Some a -> a)
    | Conjunction (a,b) -> (go state a) && (go state b)
    | Disjunction (a,b) -> (go state a) || (go state b)
    | Negation a -> not (go state a)
  in
  go state formula

(** Question 3 *)

(* TODO: Add test cases. *)
let find_satisfying_assignment_tests : (formula * truth_assignment option) list = [ 
  (parse_formula "x",Some (Variable_map.singleton "x" true));
  (parse_formula "(x|y)&z",Some (Variable_map.singleton "x" true 
                                 |> Variable_map.add "y" false
                                 |> Variable_map.add "z" true));
  (parse_formula "~x&~y",Some (Variable_map.singleton "x" false
                               |> Variable_map.add "y" false));
  (parse_formula "x&~x", None)
]

(* TODO: Implement the function. *)
let find_satisfying_assignment (formula : formula) : truth_assignment option =
  let variables = Variable_set.elements (collect_variables formula) in
  let rec try_assignments assignments =
    match assignments with
    | [] -> None
    | assignment::rest ->
      let state = List.fold_left (fun acc (var, value) -> Variable_map.add var value acc) Variable_map.empty assignment in
      try
        if eval state formula then Some state else try_assignments rest
      with
        | Unassigned_variable _ -> None
  in
  let rec all_combinations vars =
    match vars with
    | [] -> [[]]
    | v::vs ->
      let rest = all_combinations vs in
      let with_true = List.map (fun assignment -> (v, true)::assignment) rest in
      let with_false = List.map (fun assignment -> (v, false)::assignment) rest in
      with_true @ with_false
  in
  try_assignments (all_combinations variables)
```