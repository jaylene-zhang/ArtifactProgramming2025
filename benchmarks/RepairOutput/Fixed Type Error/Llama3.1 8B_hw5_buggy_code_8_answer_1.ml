```haskell
let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
  match input with
  | [] -> fail ()
  | x :: xs -> match x with
    | PLUS -> return (Plus (Var, Var))
    | RPAREN -> fail () (*default fail when unexpected token*)
    | _ -> parse_literal [x] fail (fun () -> parse_expr xs fail return)
  (*and parse_term is omitted*)
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f)
      | VAR -> return (Var)
      | _ -> fail ()
  and parse_cps t = func deriving(*ParseTemplate*)
  where
    func = parse_expr t (fun () -> None) (fun x -> Some x)
```