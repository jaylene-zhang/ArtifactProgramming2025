```OCaml
(* Q2.3: 3 points *)
let seq_predicate2
    (p1 : 'a1 -> 'b1 Maybe.t)
    (p2 : 'a2 -> 'b2 Maybe.t) : ('a1 * 'a2) -> ('b1 * 'b2) Maybe.t = 
  fun (x1, x2) ->
    match p1 x1 with
    | Some y1 ->
      (match p2 x2 with
      | Some y2 -> Some (y1, y2)
      | None -> None)
    | None -> None
;;
```