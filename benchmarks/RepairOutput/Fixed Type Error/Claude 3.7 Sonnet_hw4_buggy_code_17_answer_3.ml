The issue is in the line where you're trying to create a tuple, and there seems to be undefined functions and variables. Here's the fixed code:

```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec make_assignments vars initial acc =
    match vars with
    | [] -> acc
    | v :: vs -> make_assignments vs initial ((v, initial) :: acc)
  in
  let variables = Variable_set.elements (collect_variables formula) in
  let initial_assignments = make_assignments variables true [] in
  let initial_map = 
    List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty initial_assignments
  in
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | (var, bool_val) :: xs -> 
        if eval formula truth_assign = true then truth_assign else
          try 
            let new_assign = Variable_map.add var (not bool_val) truth_assign in
            change formula new_assign xs
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in 
  change formula initial_map (Variable_map.bindings initial_map)
```