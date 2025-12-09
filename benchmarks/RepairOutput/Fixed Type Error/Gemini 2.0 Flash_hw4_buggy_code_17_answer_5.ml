```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | (x, b) :: xs -> 
        let new_truth_assign = Variable_map.add x b truth_assign in
        if eval new_truth_assign formula = true then new_truth_assign else
          try 
            let new_truth_assign' = Variable_map.add x (not b) truth_assign in
            if eval new_truth_assign' formula = true then new_truth_assign' else
              change formula truth_assign xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in 
  let vars = Variable_set.elements (collect_variables formula) in
  let initial_assignment = List.fold_left (fun acc k -> Variable_map.add k false acc) Variable_map.empty vars in
  change formula initial_assignment (List.map (fun k -> (k, false)) vars)
```