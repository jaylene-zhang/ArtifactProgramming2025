```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let rec find_sat (truth : truth_assignment) var_list = match var_list with
    | [] -> if eval truth formula then truth else 
          raise Unsatisfiable_formula
    | v :: vs ->
        try 
          find_sat (Variable_map.add v true truth) vs 
        with 
        | Unsatisfiable_formula -> find_sat (Variable_map.add v false truth) vs
  in find_sat Variable_map.empty variable_list
```