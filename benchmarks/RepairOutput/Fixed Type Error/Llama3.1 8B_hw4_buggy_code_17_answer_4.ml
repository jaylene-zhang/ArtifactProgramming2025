```haskell
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : ('t * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | x :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          try 
            match x with 
            | (x, bool) ->
                change formula (Variable_map.set x (not bool) truth_assign ) xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in change formula 
    (Variable_map.from_list (List.map (fun (k, v) -> k, v) (Variable_set.elements (collect_variables formula)))
       (Variable_map.map (fun v -> not v) (List.map (fun k -> k, true) (Variable_set.elements (collect_variables formula))))
        truth_assign)
```