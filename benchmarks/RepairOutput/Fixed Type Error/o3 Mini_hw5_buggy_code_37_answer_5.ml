let parser_cps input : exp option =
  let rec parse_expr tokens fail succ =
    parse_term tokens fail (fun t1 tokens' ->
      let rec tail acc toks =
        match toks with
        | PLUS :: rest ->
            parse_term rest fail (fun t2 toks' ->
              tail (Plus (acc, t2)) toks')
        | _ -> succ acc toks
      in
      tail t1 tokens')
  and parse_term tokens fail succ =
    parse_factor tokens fail (fun f1 tokens' ->
      let rec tail acc toks =
        match toks with
        | TIMES :: rest ->
            parse_factor rest fail (fun f2 toks' ->
              tail (Times (acc, f2)) toks')
        | _ -> succ acc toks
      in
      tail f1 tokens')
  and parse_factor tokens fail succ =
    parse_literal tokens fail (fun lit tokens' ->
      let rec tail acc toks =
        match toks with
        | POW :: rest ->
            parse_factor rest fail (fun f toks' ->
              tail (Pow (acc, f)) toks')
        | _ -> succ acc toks
      in
      tail lit tokens')
  and parse_literal tokens fail succ =
    match tokens with
    | FLOAT f :: rest -> succ (Const f) rest
    | VAR :: rest -> succ Var rest
    | LPAREN :: rest ->
        parse_expr rest fail (fun exp toks ->
          match toks with
          | RPAREN :: rest' -> succ exp rest'
          | _ -> fail ())
    | _ -> fail ()
  in
  parse_expr input (fun () -> None) (fun exp tokens ->
    if tokens = [] then Some exp else None)

let check_parser t v =
  match parser_cps t with
  | None -> None
  | Some e -> Some (eval e v)