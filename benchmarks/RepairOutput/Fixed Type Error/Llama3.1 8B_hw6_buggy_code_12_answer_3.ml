```ocaml
let ap (mx : 'a Maybe.t) (fm : ('a -> 'b) Maybe.t) : 'b Maybe.t =
  let open Maybe in
  bind mx (fun x -> bindfm (fun f -> f x))
```