let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table value = Variable_map.map (fun _ -> value) (Variable_map.empty) in
  let rec find_sat (truth : truth_assignment) var_list = match var_list with
    | [] -> if eval truth formula then truth else
          raise Unsatisfiable_formula
    | v :: vs ->
        try find_sat (truth_table true) vs with
        | Unsatisfiable_formula -> find_sat (truth_table false) var_list
  in find_sat (truth_table true) (List.rev variable_list)