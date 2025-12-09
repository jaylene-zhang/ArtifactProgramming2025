```ocaml
let parser_cps input : exp option =
  let rec parse_expr (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: PLUS :: xs -> parse_term [x] fail (fun result rest -> succ (Plus (result, parse_expr xs fail succ)))
    | x :: xs -> parse_term t fail succ
    | [] -> fail ()
  and parse_term (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: TIMES :: xs -> parse_factor [x] fail (fun result rest -> succ (Times (result, parse_term xs fail succ)))
    | x :: xs -> parse_factor t fail succ
    | [] -> fail ()
  and parse_factor (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: POW :: xs -> parse_literal [x] fail (fun result rest -> succ (Pow (result, parse_factor xs fail succ)))
    | x :: xs -> parse_literal t fail succ
    | [] -> fail ()
  and parse_literal (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: x :: RPAREN :: xs -> parse_expr [x] fail succ
    | [] -> fail ()
    | _ -> fail ()
  in
  parse_expr input (fun x -> None) (fun x y -> Some x)
```
