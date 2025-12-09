```OCaml
(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (a1, a2) ->
    match p1 a1 with
    | Some b1 ->
      (match p2 a2 with
       | Some b2 -> Some (b1, b2)
       | None -> None)
    | None -> None
;;
```