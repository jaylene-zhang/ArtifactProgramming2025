```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : ('t * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | x :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          try 
            match x with 
            | (x, bool) ->
                change formula (Variable_map.add x (not bool) truth_assign ) (x :: xs)
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in change formula 
    (Variable_map.bind 
     (fun (x, v) -> Variable_map.add x (not v) Variable_map.empty) 
     (Variable_set.elements (collect_variables formula)))
    (Variable_map.bindings (Variable_map.bind 
       (fun x v -> Variable_map.add x (not v) Variable_map.empty) 
       (List.fold_left (fun m (x, v) -> Variable_map.add x v m) Variable_map.empty 
        (map (fun x -> (x, true)) (Variable_set.elements (collect_variables formula))))))

```