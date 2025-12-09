```ocaml
let parser_cps input : exp option =
  let rec parse_expr (t : token list) (fail : unit -> 'r) (succ : exp option -> token list -> 'r) : 'r = 
    match t with
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with
        | PLUS :: xs -> 
            succ (Some (Plus (result, (parse_expr xs fail succ))))
        | _ -> succ result xs
      )  
  and parse_term (t : token list) (fail : unit -> 'r) (succ : exp option -> token list -> 'r) : 'r = 
    match t with
    | x :: [] -> succ None t
    | x :: _ -> 
      let result = parse_factor t fail succ in
        match result with
        | None -> fail()
        | Some (Times (p1, t1)) -> succ (Some (Times(p1, t1))) t1
  and parse_factor (t : token list) (fail : unit -> 'r) (succ : exp option -> token list -> 'r) : 'r =
    match t with
    | x :: xs -> parse_literal t fail succ
  and parse_literal (t : token list) (fail : unit -> 'r) (succ : exp option -> token list -> 'r) : 'r =
    match t with 
    | FLOAT x :: xs -> succ (Some (Const x)) xs
    | VAR :: xs -> succ (Some (Var)) xs
    | LPAREN :: x :: RPAREN :: xs -> parse_expr [x] fail succ
    | _ -> fail ()
  in
  parse_expr input (fun x -> None) (fun x y -> Some x)
in
let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)
```