```ocaml
let parser_cps (t : token list) = 
  let rec expr tl sc fc =
    match tl with
    | [] -> fc ()
    | x :: xs ->
      match x with
      | PLUS -> expr xs (fun e t -> Plus(e, expr t sc fc)) fc
      | _ -> sc (expr tl (fun e t -> e) fc) tl

  and helper2 tl sc fc =
    match tl with
    | [] -> fc ()
    | x :: xs ->
      match x with
      | TIMES -> expr xs (fun e t -> Times(e, expr t sc fc)) fc
      | _ -> sc (helper2 tl (fun e t -> e) fc) tl

  and helper1 tl sc fc =
    match tl with
    | [] -> fc ()
    | x :: xs ->
      match x with
      | POW -> expr xs (fun e t -> Pow(e, expr t sc fc)) fc
      | _ -> sc (helper1 tl (fun e t -> e) fc) tl

  and factor tl sc fc =
    match tl with
    | [] -> fc ()
    | x :: xs ->
      match x with
      | FLOAT x -> sc (Const x) xs
      | VAR -> sc Var xs
      | LPAREN -> expr xs sc fc
      | RPAREN -> fc ()
      | _ -> fc ()
  in
  expr t (fun e t -> e) (fun () -> raise NotFound)
```
