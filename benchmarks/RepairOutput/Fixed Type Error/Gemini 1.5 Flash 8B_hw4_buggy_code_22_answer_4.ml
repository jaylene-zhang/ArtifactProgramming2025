```OCaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table value =
    List.fold_left (fun x y -> Variable_map.add y value x)
                   (Variable_map.empty) variable_list
  in
  let rec find_sat (truth : truth_assignment) =
    match variable_list with
    | [] -> if eval truth formula then truth else raise Unsatisfiable_formula
    | v :: vs ->
        let truth_true = truth_table true in
        try find_sat truth_true
        with Unsatisfiable_formula -> find_sat (truth_table false)
  in
  try find_sat (truth_table true)
  with Unsatisfiable_formula -> raise Unsatisfiable_formula
```
