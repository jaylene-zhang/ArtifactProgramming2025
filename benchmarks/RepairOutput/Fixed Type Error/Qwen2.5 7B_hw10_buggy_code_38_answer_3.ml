```ocaml
and check ctx exps tps result =
  match exps, tps with
  | [], [] -> result
  | e :: es, t :: ts ->
      let t' = infer ctx e in
      if t = t' then check ctx es ts result
      else type_mismatch t t'
  | _ -> raise (TypeError Arity_mismatch)
```

```ocaml
| Rec (f, t, e) -> 
      let ctx' = extend ctx (f, t) in
      let t' = infer ctx' e in
      if t = t' then
        t
      else
        type_mismatch t t'
```