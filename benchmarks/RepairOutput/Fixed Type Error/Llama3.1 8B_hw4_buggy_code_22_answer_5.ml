```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table value : truth_assignment Map.Make(String).t = Map.Make(String).fold_left (fun x y -> Map.Make(String).add y value x) (Map.Make(String).empty variable_list) (variable_set_to_list (collect_variables formula)) in
  let rec find_sat (truth : truth_assignment Map.Make(String).t) var_list = match var_list with
  | [] -> if eval truth formula then truth_table true else 
          raise Unsatisfiable_formula
  | v :: vs ->
      try find_sat (truth_table true) vs with 
      | Unsatisfiable_formula -> find_sat (truth_table false) var_list
in
```