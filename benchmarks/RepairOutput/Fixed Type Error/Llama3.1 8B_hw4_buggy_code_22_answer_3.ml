```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let rec truth_table value : truth_assignment =
    match variable_list with
    | [] -> Variable_map.empty
    | v :: vs -> 
      let rec fold_with value = function
        | [] -> Variable_map.empty
        | var :: v_list -> Variable_map.add var value (fold_with value v_list) in
      fold_with value variable_list
  in
  let rec find_sat (truth : truth_assignment) var_list = match var_list with
    | [] -> if eval truth formula then truth else raise Unsatisfiable_formula
    | v :: vs ->
        try find_sat (truth_table true) vs with 
        | Unsatisfiable_formula -> find_sat (truth_table false) var_list
  in find_sat (truth_table true) variable_list
```