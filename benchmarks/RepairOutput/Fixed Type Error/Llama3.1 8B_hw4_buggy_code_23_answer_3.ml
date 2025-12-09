```ocaml
let rec collect_variables (formula : formula) : Variable_set.t =
  match formula with
  | Variable(x) -> if Variable_set.is_empty Variable_set.empty then Variable_set.singleton x else Variable_set.add x Variable_set.empty
  | Conjunction(f1, f2) -> Variable_set.union (collect_variables f1) (collect_variables f2)
  | Disjunction(f1, f2) -> Variable_set.union (collect_variables f1) (collect_variables f2)
  | Negation(f) -> collect_variables f
```
I changed the way we deal with `Variable_set.empty`, and the way we union variable sets. Now `collect_variables` correctly returns a variable set containing all variables that appear in the formula.