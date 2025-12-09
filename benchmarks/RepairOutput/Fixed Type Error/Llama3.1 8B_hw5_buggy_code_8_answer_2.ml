```haskell
let parse_cps t =
  let rec parse_expr (input : token list) (result : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var))
      | _ -> return (Times (parse_literal xs result return, parse_factor xs result return))
  and parse_literal (input : token list) (result : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f)
      | VAR -> return (Var)
      | _ -> result ()
  and parse_factor (input : token list) (result : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | LPAREN -> parse_expr xs (fun () -> fail ()) (return)
      | RPAREN -> result ()
      | f :: xs when Member List mem (f, xs) -> parse_literal xs result (fun x -> return x)
      | _ -> result ()
  in parse_expr t (fun () -> fail ()) (fun x -> x)
```