```haskell
let rec collect_variables (formula : formula) : Variable_set.t = 
  match formula with
  | Variable(x) -> Variable_set.add x Variable_set.empty
  | Conjunction(f1, f2) -> Variable_set.union (collect_variables f1) (collect_variables f2)
  | Disjunction(f1, f2) -> Variable_set.union (collect_variables f1) (collect_variables f2)
  | Negation(f) -> Variable_set.union (Collect_variables f) Variable_set.empty
```