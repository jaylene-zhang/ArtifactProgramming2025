let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change formula truth_assign lst =
    match lst with
    | [] -> raise Unsatisfiable_formula
    | (var, b) :: xs ->
        if eval truth_assign formula then truth_assign
        else
          try
            change formula (Variable_map.add var (not b) truth_assign) ((var, not b) :: xs)
          with
          | Unsatisfiable_formula -> change formula truth_assign xs
  in
  let vars = Variable_set.elements (collect_variables formula) in
  let init_list = List.map (fun v -> (v, true)) vars in
  let init_assign =
    List.fold_left (fun m (k, v) -> Variable_map.add k v m)
      Variable_map.empty init_list
  in
  change formula init_assign (Variable_map.bindings init_assign)