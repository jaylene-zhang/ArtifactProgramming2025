```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | (x,b) :: xs -> 
        let updated_truth_assign = Variable_map.add x b truth_assign in
        if eval updated_truth_assign formula = true then updated_truth_assign else
          try 
             change formula (Variable_map.add x (not b) truth_assign ) xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in 
  let vars = Variable_set.elements (collect_variables formula) in
  let initial_assignment = List.fold_left (fun m k -> Variable_map.add k true m) Variable_map.empty vars in
  change formula initial_assignment (List.map (fun v -> (v,true)) vars)
```