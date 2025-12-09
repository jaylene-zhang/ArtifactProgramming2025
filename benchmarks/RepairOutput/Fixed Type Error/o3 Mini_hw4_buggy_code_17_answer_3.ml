let find_satisfying_assignment (formula : formula) : truth_assignment =
  let initial_vars =
    List.map (fun x -> (x, true)) (Variable_set.elements (collect_variables formula))
  in
  let initial_truth =
    List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty initial_vars
  in
  let rec change (formula : formula) (truth_assign : truth_assignment) (lst : (string * bool) list) : truth_assignment =
    match lst with
    | [] -> raise Unsatisfiable_formula
    | (var, b) :: xs ->
        if eval truth_assign formula then truth_assign
        else
          try
            change formula (Variable_map.add var (not b) truth_assign) ((var, not b) :: xs)
          with Unsatisfiable_formula ->
            change formula truth_assign xs
  in
  change formula initial_truth (Variable_map.bindings initial_truth)