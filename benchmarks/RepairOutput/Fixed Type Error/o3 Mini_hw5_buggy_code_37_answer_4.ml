let parser_cps input : exp option =
  let rec parse_expr (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    parse_term t fail (fun left t' ->
      match t' with
      | PLUS :: ts ->
          parse_expr ts fail (fun right t'' ->
            succ (Plus (left, right)) t'')
      | _ -> succ left t')
  and parse_term (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    parse_factor t fail (fun left t' ->
      match t' with
      | TIMES :: ts ->
          parse_term ts fail (fun right t'' ->
            succ (Times (left, right)) t'')
      | _ -> succ left t')
  and parse_factor (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    parse_literal t fail (fun left t' ->
      match t' with
      | POW :: ts ->
          parse_factor ts fail (fun right t'' ->
            succ (Pow (left, right)) t'')
      | _ -> succ left t')
  and parse_literal (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    match t with 
    | FLOAT x :: ts -> succ (Const x) ts
    | VAR :: ts -> succ Var ts
    | LPAREN :: ts ->
        parse_expr ts fail (fun e t' ->
          match t' with
          | RPAREN :: ts' -> succ e ts'
          | _ -> fail ())
    | _ -> fail ()
  in
  parse_expr input (fun () -> None)
    (fun e t -> match t with [] -> Some e | _ -> None)

let check_parser t v =
  match parser_cps t with
  | None -> None
  | Some e -> Some (eval e v)