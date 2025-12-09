```hindler
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'a) (return : exp -> token list -> 'a) : 'a =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var))
      | _ -> parse_literal x xs fail return
  and parse_literal (input : token list) (fail : unit -> 'a) (return : exp -> token list -> 'a) : 'a =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f)
      | VAR -> return (Var)
      | _ -> parse_factor xs fail return
  and parse_factor (input : token list) (fail : unit -> 'a) (return : exp -> token list -> 'a) : 'a =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | TIMES -> parse_factor input fail return
      | POW -> parse_factor input fail return
      | LPAREN -> parse_expr input fail return
      | RPAREN -> parse_literal input fail return
      | FLOAT f -> return (Const f)
      | VAR -> return (Var)
      | _ -> fail ()
in parse_expr t (fun () -> None) (fun x -> Some x)
```