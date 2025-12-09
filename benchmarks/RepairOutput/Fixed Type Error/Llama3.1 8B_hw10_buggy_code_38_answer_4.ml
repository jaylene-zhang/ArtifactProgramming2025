```haskell
let check ctx exps tps result =
  match exps, tps with
  | [], [] -> result
  | e :: es, t :: ts ->
      let t' = infer ctx e in
      if t = t' then check ctx es ts result
      else raise (TypeError (Type_mismatch t t'))
  | _ -> raise (TypeError Arity_mismatch)```