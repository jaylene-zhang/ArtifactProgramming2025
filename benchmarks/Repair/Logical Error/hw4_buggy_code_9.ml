(** Question 1 *)

(* TODO: Add test cases. *)
let collect_variables_tests : (formula * Variable_set.t) list = [
  (parse_formula "x", Variable_set.singleton("x"));
  (parse_formula "x & y", Variable_set.singleton("x") 
                          |> Variable_set.add("y"));
  (parse_formula "x & ~y", Variable_set.singleton("x") 
                           |> Variable_set.add("y"));
  (parse_formula "x | ~y & z", Variable_set.singleton("x") 
                               |> Variable_set.add("y")
                               |> Variable_set.add("z"));
  (parse_formula "~(~(x | ~(y & z)))", Variable_set.singleton("x") 
                                       |> Variable_set.add("y")
                                       |> Variable_set.add("z"));
]

(* TODO: Implement the function. *)
let collect_variables (formula : formula) : Variable_set.t =
  let rec collect_variables_rec (formula : formula) (accumulator: Variable_set.t): Variable_set.t = 
    match formula with 
    | Variable v -> accumulator |> Variable_set.add(v)
    | Conjunction (e1, e2)-> collect_variables_rec e1 (collect_variables_rec e2 accumulator)
    | Disjunction (e1, e2) -> collect_variables_rec e1 (collect_variables_rec e2 accumulator)
    | Negation v -> collect_variables_rec v accumulator
  in collect_variables_rec formula Variable_set.empty


(** Question 2 *)

(* TODO: Add test cases. *)
let eval_success_tests : ((truth_assignment * formula) * bool) list = [
  (((Variable_map.singleton("x") true |> Variable_map.add "y" true), parse_formula("~((x | y) & ~(x & y))")), true);
  (((Variable_map.singleton("x") false |> Variable_map.add "y" true), parse_formula("~(~(x | y) & ~(x & y))")), true); 
]

(* TODO: Add test cases. *)
let eval_failure_tests : ((truth_assignment * formula) * exn) list = [ 
  (((Variable_map.singleton("x") true), parse_formula("((x | y) & ~(x & y))")), Unassigned_variable("y"));
  (((Variable_map.empty), parse_formula("x & ~x")), Unassigned_variable("x")); 
]

(* TODO: Implement the function. *)
let eval (state : truth_assignment) (formula : formula) : bool =
  let find_value var =
    let value = state |> Variable_map.find_opt var in
    match value with
    | Some true -> true
    | Some false -> false
    | None -> raise (Unassigned_variable var)
  in 
  let rec collect_variables_rec (formula : formula) (current_bool: bool): bool = 
    match formula with 
    | Variable v ->  find_value v && current_bool
    | Conjunction (e1, e2)-> collect_variables_rec e1 (collect_variables_rec e2 current_bool)
    | Disjunction (e1, e2) -> collect_variables_rec e1 (collect_variables_rec e2 current_bool)
    | Negation v -> (not (collect_variables_rec v current_bool))
  in collect_variables_rec formula true
  
  (*
    let find_value var =
      let ans = state |> Variable_map.find_opt input in
      match ans with
      | Some true -> true
      | Some false -> false
      | None -> raise (Unassigned_variable input) 
    in
  
    let rec eval_rec (state : truth_assignment) (formula : formula) (current_bool: bool): bool = 
      match formula with 
      | Variable v -> (state |> Variable_map.find_opt v) && current_bool
      | Conjunction (e1, e2)-> collect_variables_rec e1 (collect_variables_rec e2 accumulator)
      | Disjunction (e1, e2) -> collect_variables_rec e1 (collect_variables_rec e2 accumulator)
      | Negation v -> collect_variables_rec v accumulator
    in eval_rec state formula
  *)

(** Question 3 *)

(* TODO: Add test cases. *)
let find_satisfying_assignment_tests : (formula * truth_assignment option) list = [
  (parse_formula("~x"), Some (Variable_map.singleton "x" false));
  (parse_formula("x & ~y & z"), Some (Variable_map.singleton "x" true |> Variable_map.add "y" false |> Variable_map.add "z" true));
  (parse_formula("~x & x"), None);
  (parse_formula("(~(x & ~y) | x) | z"), Some (Variable_map.singleton "x" true |> Variable_map.add "y" false |> Variable_map.add "z" true))
]

let creating_map formula = 
  let rec create_map vars map =
    match vars with 
    | [] -> map
    | x::xs -> create_map xs (map |> Variable_map.add x false)
  in create_map (Variable_set.elements (collect_variables formula)) Variable_map.empty 


(* TODO: Implement the function. *)
let find_satisfying_assignment (formula : formula) : truth_assignment =
  (*let all_var = collect_variables formula
   in Variable_map.empty*)
  creating_map formula
