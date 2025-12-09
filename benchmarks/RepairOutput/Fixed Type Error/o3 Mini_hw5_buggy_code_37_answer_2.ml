type token = LPAREN | RPAREN | FLOAT of float | TIMES | POW | VAR | PLUS

type exp =
  Const of float
| Var
| Plus of exp * exp
| Times of exp * exp
| Pow of exp * exp

let rec parse_expr t fail succ =
  parse_term t fail (fun term t' ->
    match t' with
    | PLUS :: t'' ->
        parse_expr t'' fail (fun expr t''' ->
          succ (Plus(term, expr)) t''')
    | _ -> succ term t'
  )
and parse_term t fail succ =
  parse_factor t fail (fun factor t' ->
    match t' with
    | TIMES :: t'' ->
        parse_term t'' fail (fun term t''' ->
          succ (Times(factor, term)) t''')
    | _ -> succ factor t'
  )
and parse_factor t fail succ =
  parse_literal t fail (fun lit t' ->
    match t' with
    | POW :: t'' ->
        parse_factor t'' fail (fun factor t''' ->
          succ (Pow(lit, factor)) t''')
    | _ -> succ lit t'
  )
and parse_literal t fail succ =
  match t with
  | FLOAT x :: t' -> succ (Const x) t'
  | VAR :: t' -> succ Var t'
  | LPAREN :: t' ->
      parse_expr t' fail (fun exp t'' ->
        match t'' with
        | RPAREN :: t''' -> succ exp t'''
        | _ -> fail ())
  | _ -> fail ()

let parser_cps input : exp option =
  parse_expr input (fun () -> None) (fun exp t -> if t = [] then Some exp else None)

let check_parser t v =
  match parser_cps t with
  | None -> None
  | Some e -> Some (eval e v)