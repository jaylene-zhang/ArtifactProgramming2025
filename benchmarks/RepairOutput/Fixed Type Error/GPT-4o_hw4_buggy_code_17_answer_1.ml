```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (Variable_map.key * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | (x, bool) :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          try 
            change formula (Variable_map.add x (not bool) truth_assign ) xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in
  let initial_assignment =
    List.fold_left 
      (fun m k -> Variable_map.add k true m) 
      Variable_map.empty 
      (Variable_set.elements (collect_variables formula))
  in
  let variable_list = Variable_map.bindings initial_assignment in
  change formula initial_assignment variable_list
```