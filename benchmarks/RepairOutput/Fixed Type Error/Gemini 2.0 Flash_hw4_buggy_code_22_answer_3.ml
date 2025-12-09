```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table value : truth_assignment =
    let map = Variable_map.empty in
    List.fold_left (fun acc var -> Variable_map.add var value acc) map variable_list
  in
  let rec find_sat (truth : truth_assignment) var_list =
    match var_list with
    | [] ->
        if eval truth formula then truth else raise Unsatisfiable_formula
    | v :: vs ->
        try find_sat (truth_table true) vs
        with Unsatisfiable_formula -> find_sat (truth_table false) vs
  in
  try find_sat (truth_table false) variable_list with Unsatisfiable_formula ->
    raise Unsatisfiable_formula
```