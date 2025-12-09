let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change formula truth_assign lst =
    match lst with
    | [] -> raise Unsatisfiable_formula 
    | (var, value) :: xs ->
        if eval truth_assign formula = true then truth_assign
        else
          try 
            change formula (Variable_map.add var (not value) truth_assign) ((var, not value) :: xs)
          with
          | Unsatisfiable_formula -> change formula truth_assign xs
  in
  let initial_list =
    List.map (fun key -> (key, true)) (Variable_set.elements (collect_variables formula))
  in
  let initial_assignment =
    List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty initial_list
  in
  change formula initial_assignment initial_list