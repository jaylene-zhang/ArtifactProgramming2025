let parser_cps input : exp option =
  let rec parse_expr t fail succ =
    parse_term t fail (fun t_val rest ->
      match rest with
      | PLUS :: rest' ->
          parse_expr rest' fail (fun e rest'' ->
            succ (Plus (t_val, e)) rest'')
      | _ -> succ t_val rest)
  and parse_term t fail succ =
    parse_factor t fail (fun f_val rest ->
      match rest with
      | TIMES :: rest' ->
          parse_term rest' fail (fun t_val rest'' ->
            succ (Times (f_val, t_val)) rest'')
      | _ -> succ f_val rest)
  and parse_factor t fail succ =
    parse_literal t fail (fun lit rest ->
      match rest with
      | POW :: rest' ->
          parse_factor rest' fail (fun p rest'' ->
            succ (Pow (lit, p)) rest'')
      | _ -> succ lit rest)
  and parse_literal t fail succ =
    match t with
    | FLOAT f :: rest -> succ (Const f) rest
    | VAR :: rest -> succ Var rest
    | LPAREN :: rest ->
        parse_expr rest fail (fun e rest' ->
          match rest' with
          | RPAREN :: rest'' -> succ e rest''
          | _ -> fail ())
    | _ -> fail ()
  in
  parse_expr input (fun () -> None) (fun e rest -> if rest = [] then Some e else None)

let check_parser t v =
  match parser_cps t with
  | None -> None
  | Some e -> Some (eval e v)