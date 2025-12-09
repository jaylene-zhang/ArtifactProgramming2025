```OCaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula
    | (var, val_bool) :: xs ->
        let new_assign = Variable_map.add var val_bool truth_assign in
        if eval new_assign formula then new_assign
        else
          try change formula new_assign xs
          with Unsatisfiable_formula -> change formula truth_assign xs
  in change formula
    (List.fold_left (fun m (k,v) -> Variable_map.add k v m) Variable_map.empty (Variable_set.elements (collect_variables formula)))
    (List.map (fun v -> (v, false)) (Variable_set.elements (collect_variables formula)))
```
