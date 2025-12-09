let parser_cps (input : token list) : exp option =
  let rec parse_expr t fail succ =
    parse_term t fail (fun result rest ->
      match rest with
      | PLUS :: rest' ->
          parse_expr rest' fail (fun r rest'' ->
            succ (Plus(result, r)) rest'')
      | _ -> succ result rest)
  and parse_term t fail succ =
    parse_factor t fail (fun result rest ->
      match rest with
      | TIMES :: rest' ->
          parse_term rest' fail (fun r rest'' ->
            succ (Times(result, r)) rest'')
      | _ -> succ result rest)
  and parse_factor t fail succ =
    parse_literal t fail (fun result rest ->
      match rest with
      | POW :: rest' ->
          parse_factor rest' fail (fun r rest'' ->
            succ (Pow(result, r)) rest'')
      | _ -> succ result rest)
  and parse_literal t fail succ =
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs ->
        parse_expr xs fail (fun e rest ->
          match rest with
          | RPAREN :: rest' -> succ e rest'
          | _ -> fail ())
    | _ -> fail ()
  in
  parse_expr input (fun () -> None) (fun x rest ->
    if rest = [] then Some x else None)

let check_parser t v =
  match parser_cps t with
  | None -> None
  | Some e -> Some (eval e v)