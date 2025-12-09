```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (Variable_map.key * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | x :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          try 
            match x with 
            | (var, bool) ->
                change formula (Variable_map.add var (not bool) truth_assign ) xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in 
  let initial_assignments = List.map (fun var -> (var, true)) (Variable_set.elements (collect_variables formula)) in
  change formula truth_assign initial_assignments
```