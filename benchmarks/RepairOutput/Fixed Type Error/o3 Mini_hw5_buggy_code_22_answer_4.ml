let parser_cps (t : token list) =
  let rec expr tl sc fc =
    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | PLUS -> Plus (e, expr xs sc fc)
          | _ -> sc e t
    in
    helper2 tl nsc fc

  and helper2 tl sc fc =
    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | TIMES -> Times (e, expr xs sc fc)
          | _ -> sc e t
    in
    helper1 tl nsc fc

  and helper1 tl sc fc =
    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | POW -> Pow (e, expr xs sc fc)
          | _ -> sc e t
    in
    factor tl nsc fc

  and factor tl sc fc =
    match tl with
    | [] -> raise NotFound
    | x :: xs ->
        match x with
        | FLOAT f -> sc (Const f) xs
        | VAR -> sc Var xs
        | LPAREN -> expr xs sc fc
        | RPAREN -> raise NotFound
        | _ -> fc ()
  in
  expr t (fun e t -> e) (fun () -> raise NotFound)