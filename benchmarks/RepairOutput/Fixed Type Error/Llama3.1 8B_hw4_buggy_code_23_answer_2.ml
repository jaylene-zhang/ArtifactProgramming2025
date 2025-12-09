```cilang
let rec collect_variables (formula : formula) : Variable_set.t = 
  match formula with
  | Variable(x) -> Variable_set.singleton x
  | Conjunction(f1, f2) -> Variable_set.union (collect_variables f1) (collect_variables f2)
  | Disjunction(f1, f2) -> Variable_set.union (collect_variables f1) (collect_variables f2)
  | Negation(f) -> Variable_set.union (Variable_set.singleton Gen.String.empty) (collect_variables f)
```