```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let rec find_sat (truth : truth_assignment) var_list = match var_list with
    | [] -> if eval truth formula then truth else 
          raise Unsatisfiable_formula
    | v :: vs ->
        let truth_with_true = Variable_map.add v true truth in
        try find_sat truth_with_true vs with 
        | Unsatisfiable_formula ->
            let truth_with_false = Variable_map.add v false truth in
            find_sat truth_with_false vs
  in find_sat Variable_map.empty variable_list
```