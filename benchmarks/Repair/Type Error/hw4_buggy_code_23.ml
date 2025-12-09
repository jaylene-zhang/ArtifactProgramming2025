
let rec collect_variables (formula : formula) : Variable_set.t = 
  match formula with
  | Variable(x) -> if (Variable_set.empty = true) then Variable_set.singleton x
  | Conjunction(f1, f2) -> collect_variables(f1); collect_variables(f2)
  | Disjunction(f1, f2) -> collect_variables(f1); collect_variables(f2)
  | Negation(f) -> collect_variables(f)
