```ocaml
let parser_cps input : exp option =
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with 
    | [] -> fail()
    | x :: xs -> 
        parse_term t fail (fun result rest -> 
          match rest with 
          | PLUS :: tail -> 
              parse_expr tail fail (fun rhs rest' -> succ (Plus(result, rhs)) rest')
          | _ -> succ result rest
        )
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> 
        parse_factor t fail (fun result rest -> 
          match rest with
          | TIMES :: tail -> 
              parse_term tail fail (fun rhs rest' -> succ (Times(result, rhs)) rest')
          | _ -> succ result rest
        )
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> 
        parse_literal t fail (fun result rest -> 
          match rest with
          | POW :: tail -> 
              parse_factor tail fail (fun rhs rest' -> succ (Pow(result, rhs)) rest')
          | _ -> succ result rest
        )
      
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: rest -> 
        parse_expr rest fail (fun result rem -> 
          match rem with
          | RPAREN :: tail -> succ result tail
          | _ -> fail ()
        )
    | _ -> fail ()
      
  in
  parse_expr input (fun () -> None) (fun x _ -> Some x)
```