Here is the fixed code:
```ocaml
| Rec (f, t, e) -> 
    let ctx' = extend ctx (f, t) in
    let t' = infer ctx' e in
    if t = t' then
      t
    else
      type_mismatch t t'
```