```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table (value : bool) : truth_assignment =
    match variable_list with
    | [] -> Variable_map.empty
    | v :: vs ->
        List.fold_left
          (fun acc var -> Variable_map.add var value acc)
          (Variable_map.singleton v value)
          vs
  in
  let rec find_sat (truth : truth_assignment) var_list =
    match var_list with
    | [] ->
        if eval truth formula then truth
        else raise Unsatisfiable_formula
    | v :: vs ->
        try
          let new_truth =
            List.fold_left
              (fun acc var -> Variable_map.add var (Variable_map.find v truth) acc)
              truth
              (v :: vs)
          in
          find_sat (truth_table true) vs
        with Unsatisfiable_formula -> find_sat (truth_table false) vs
  in
  try find_sat (truth_table true) variable_list
  with Unsatisfiable_formula -> raise Unsatisfiable_formula
```