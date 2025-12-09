The error is that when calling `change` in the `let rec change` function with a tuple `(x, bool)`, you're trying to add `x` to a list, but `x` is a key of type `string` (Variable_map.key). You need to create a tuple of the key and the new boolean value.

```ocaml
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let rec change (formula: formula) (truth_assign: truth_assignment) (list : (string * bool) list): truth_assignment =
    match list with
    | [] -> raise Unsatisfiable_formula 
    | (x, bool) :: xs -> 
        if eval truth_assign formula = true then truth_assign else
          try 
            change formula (Variable_map.add x (not bool) truth_assign) ((x, not bool) :: xs)
          with
            Unsatisfiable_formula -> change formula truth_assign xs
  in change formula 
    (List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty (tuple (Variable_set.elements (collect_variables formula)) true []))
    (Variable_map.bindings (List.fold_left (fun m (k, v) -> Variable_map.add k v m) Variable_map.empty (tuple (Variable_set.elements (collect_variables formula)) true [])))
```