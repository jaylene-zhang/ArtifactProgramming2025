```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | (x,b) :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          
            let new_truth_assign = Variable_map.add x (not b) truth_assign in
              try 
                change formula new_truth_assign xs
              with
                Unsatisfiable_formula -> change formula truth_assign xs
  in 
  let var_list = Variable_set.elements (collect_variables formula) in
  let initial_assignment = List.fold_left (fun m k -> Variable_map.add k false m) Variable_map.empty var_list in
  let assignment_list = Variable_map.bindings initial_assignment in
    change formula initial_assignment assignment_list
```