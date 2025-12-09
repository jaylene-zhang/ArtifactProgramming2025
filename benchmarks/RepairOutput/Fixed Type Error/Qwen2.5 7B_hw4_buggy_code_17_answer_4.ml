```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | x :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          try 
            match x with 
            | (x, bool) ->
                change formula (Variable_map.add x (not bool) truth_assign ) xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in change formula 
    (List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty (tuple (Variable_set.elements (collect_variables formula)) true [])) 
    (Variable_map.bindings (List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty (tuple (Variable_set.elements (collect_variables formula)) true [])))
```