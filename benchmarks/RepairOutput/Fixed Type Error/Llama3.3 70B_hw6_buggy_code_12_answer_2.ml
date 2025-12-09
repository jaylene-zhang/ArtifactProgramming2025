```ocaml
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  fm >>= (fun f -> bind mx (return f))
```