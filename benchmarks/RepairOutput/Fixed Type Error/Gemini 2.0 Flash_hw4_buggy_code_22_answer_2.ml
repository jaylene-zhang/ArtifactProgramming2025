```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table (value : bool) : truth_assignment =
    match variable_list with
    | [] -> Variable_map.empty
    | v :: vs ->
        List.fold_left (fun acc var -> Variable_map.add var value acc)
          (Variable_map.singleton v value) vs
  in
  let rec find_sat (truth : truth_assignment) var_list =
    match var_list with
    | [] ->
        if eval truth formula then truth
        else raise Unsatisfiable_formula
    | v :: vs ->
        let truth' = truth_table true in
        try find_sat (List.fold_left (fun acc var -> Variable_map.add var true acc) truth' variable_list) vs with
        | Unsatisfiable_formula ->
            let truth'' = truth_table false in
            find_sat (List.fold_left (fun acc var -> Variable_map.add var false acc) truth'' variable_list) vs
  in
  try find_sat Variable_map.empty variable_list with Unsatisfiable_formula -> raise Unsatisfiable_formula
```