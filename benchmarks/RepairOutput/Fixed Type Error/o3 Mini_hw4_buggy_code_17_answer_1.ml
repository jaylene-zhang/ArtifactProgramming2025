let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change formula truth_assign lst =
    if eval truth_assign formula then truth_assign
    else
      match lst with
      | [] -> raise Unsatisfiable_formula
      | (x, b)::xs ->
          try
            change formula (Variable_map.add x (not b) truth_assign) ((x, not b)::xs)
          with
          | Unsatisfiable_formula -> change formula truth_assign xs
  in
  let vars = Variable_set.elements (collect_variables formula) in
  let init_list = List.map (fun var -> (var, true)) vars in
  let init_truth =
    List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty init_list
  in
  change formula init_truth (Variable_map.bindings init_truth)