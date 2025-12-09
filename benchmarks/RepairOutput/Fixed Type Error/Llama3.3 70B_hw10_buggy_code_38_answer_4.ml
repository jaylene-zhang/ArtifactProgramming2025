```
  | Rec (f, t, e) -> 
      let ctx' = extend ctx (f, t) in
      let t' = infer e ctx' in
      if t = t' then
        t
      else
        type_mismatch t t'
```