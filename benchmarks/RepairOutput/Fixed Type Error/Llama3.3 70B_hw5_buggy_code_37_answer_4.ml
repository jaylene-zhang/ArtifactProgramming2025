```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> 
        match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun expr rest -> succ (Plus (result, expr)) rest)
        | _ -> succ result xs
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with
    | x :: TIMES :: xs -> parse_factor [x] fail (fun result rest -> 
        parse_term xs fail (fun term rest -> succ (Times (result, term)) rest))
    | x :: xs -> parse_factor t fail succ
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: POW :: xs -> parse_literal [x] fail (fun result rest -> 
        parse_factor xs fail (fun factor rest -> succ (Pow (result, factor)) rest))
    | x :: xs -> parse_literal t fail succ
      
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r =
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs -> parse_expr xs fail (fun expr rest -> 
        match rest with 
        | RPAREN :: xs -> succ expr xs
        | _ -> fail ())
    | _ -> fail ()
      
      
  in
  
  parse_expr input (fun x -> None) (fun x y -> Some x)
      
```