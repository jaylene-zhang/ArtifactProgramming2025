```
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let variable_list = variable_set_to_list (collect_variables formula) in
  let truth_table value variable : truth_assignment = 
    Variable_map.singleton variable value in
  let rec find_sat var_list = match var_list with
    | [] -> if eval Variable_map.empty formula then Variable_map.empty else 
          raise Unsatisfiable_formula
    | v :: vs ->
        try find_sat vs with 
        | Unsatisfiable_formula -> 
          try find_sat vs with 
          | Unsatisfiable_formula -> find_sat vs
  in find_sat (List.hd variable_list) (List.tl variable_list)
```