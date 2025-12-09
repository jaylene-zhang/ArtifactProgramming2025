(** Question 1 *)

(* TODO: Add test cases. *)
let form = parse_formula "(a | ~b) & c"
let form1 : Variable_set.t = Variable_set.singleton "a" |> Variable_set.add "b" |> Variable_set.add "c" 
let form2 = Variable ("")
let form3 : Variable_set.t = Variable_set.empty
let collect_variables_tests : (formula * Variable_set.t) list = [
  (form, form1);
  (parse_formula "~(x & y)", Variable_set.singleton "x" |> Variable_set.add "y");
  (parse_formula "a | a & ~c", Variable_set.singleton "a" |> Variable_set.add "c");
  (parse_formula "((~(~(~(a))) & c) | b) & ~b", Variable_set.singleton "a" |> Variable_set.add "b" |> Variable_set.add "c"); 
  (parse_formula "(~a | ~b) & ((~c | d) & e) & (f & ~g)", Variable_set.singleton "a" |> Variable_set.add "b" |> Variable_set.add "c" |> Variable_set.add "d" |> Variable_set.add "e" |> Variable_set.add "f" |> Variable_set.add "g");
  
]

(* TODO: Implement the function. *)
let collect_variables (formula : formula) : Variable_set.t = 
  let rec collect_variables_rec (formula : formula) : Variable_set.t = 
    let set_result : Variable_set.t = Variable_set.empty in
    match formula with
    | Variable x -> let set : Variable_set.t = Variable_set.singleton x in
        Variable_set.union set set_result
    | Conjunction (f1, f2) -> 
        let exp1 = collect_variables_rec f1 in
        let exp2 = collect_variables_rec f2 in
        Variable_set.union exp1 exp2
    | Disjunction (f1, f2) ->
        let exp1 = collect_variables_rec f1 in
        let exp2 = collect_variables_rec f2 in
        Variable_set.union exp1 exp2
    | Negation (f1) -> collect_variables_rec f1
  in
  collect_variables_rec formula
        
      
      
(** Question 2 *)

(* TODO: Add test cases. *)
let eval_success_tests : ((truth_assignment * formula) * bool) list = [
  (((Variable_map.singleton "x" true) , (parse_formula "x")), true);
  (((Variable_map.singleton "x" true |> Variable_map.add "y" false) , (parse_formula "x & ~y")), true);
  (((Variable_map.singleton "x" true |> Variable_map.add "x" true) , (parse_formula "x & ~x")), false);
  (((Variable_map.singleton "x" true |> Variable_map.add "y" false |> Variable_map.add "z" false) , (parse_formula "x | y | z")), true);
  (((Variable_map.singleton "x" true |> Variable_map.add "y" false |> Variable_map.add "z" true) , (parse_formula "x & y | z")), true);
  (((Variable_map.singleton "x" true |> Variable_map.add "y" false |> Variable_map.add "z" true) , (parse_formula "x & y | ~z")), false);
]

(* TODO: Add test cases. *)
let eval_failure_tests : ((truth_assignment * formula) * exn) list = [
  (((Variable_map.singleton "x" true) , (parse_formula "y")), Unassigned_variable "y");
]

(* TODO: Implement the function. *)
let rec eval (state : truth_assignment) (formula : formula) : bool = match formula with
  | Negation f -> 
      let neg_truth = eval state f in
      if neg_truth = true then false 
      else true
  | Conjunction (f1, f2) ->
      let con_truth1 = eval state f1 in
      let con_truth2 = eval state f2 in
      if con_truth1 = true && con_truth2 = true then true
      else if con_truth1 = false && con_truth2 = true then false
      else if con_truth1 = true && con_truth2 = false then false
      else false 
  | Disjunction (f1, f2) ->
      let dis_truth1 = eval state f1 in
      let dis_truth2 = eval state f2 in
      if dis_truth1 = true && dis_truth2 = true then true
      else if dis_truth1 = false && dis_truth2 = true then true
      else if dis_truth1 = true && dis_truth2 = false then true
      else false 
  | Variable x -> 
      let truth = Variable_map.find_opt x state in
      match truth with
      | None -> raise (Unassigned_variable x)
      | Some v -> v 
  

(** Question 3 *)

(* TODO: Add test cases. *)
let find_satisfying_assignment_tests : (formula * truth_assignment option) list = [
  (parse_formula "x & ~x", None );
  (parse_formula "~x", Some (Variable_map.singleton "x" false));
  (parse_formula "x & y & z", Some (Variable_map.singleton "x" true |> Variable_map.add "y" true |> Variable_map.add "z" true));
  (parse_formula "a | b", Some (Variable_map.singleton "a" true |> Variable_map.add "b" false));
  (parse_formula "a & ~b", Some (Variable_map.singleton "a" true |> Variable_map.add "b" false));
  (parse_formula "(a & b) | c", Some (Variable_map.singleton "a" false |> Variable_map.add "b" false |> Variable_map.add "c" true));
  (parse_formula "~((a & b) | c)", Some (Variable_map.singleton "a" false |> Variable_map.add "b" false |> Variable_map.add "c" false)); 
  (parse_formula "~(~((a & b) | c))", Some (Variable_map.singleton "a" false |> Variable_map.add "b" false |> Variable_map.add "c" true));
] 

(* TODO: Implement the function. *)
let rec find_satisfying_assignment (formula : formula) : truth_assignment = 
  match formula with 
  | Negation f ->
      let state_neg = find_satisfying_assignment f in
      
      
      
      
      
