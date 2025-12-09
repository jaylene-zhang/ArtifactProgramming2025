```haskell
let rec collect_variables (formula : formula) : Variable_set.t = 
  match formula with
  | Variable(x) -> Variable_set.add x Variable_set.empty
  | Conjunction(f1, f2) -> 
     let set1 = collect_variables f1 in
     let set2 = collect_variables f2 in
     List.union set1 set2 
  | Disjunction(f1, f2) -> 
     let set1 = collect_variables f1 in
     let set2 = collect_variables f2 in
     List.union set1 set2
  | Negation(f) -> collect_variables f
```