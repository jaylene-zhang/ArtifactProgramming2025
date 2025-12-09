```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | [] -> fail ()
    | _ -> parse_term t fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun expr rest' -> succ (Plus (result, expr)) rest')
        | _ -> succ result rest
      )
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | [] -> fail ()
    | _ -> parse_factor t fail (fun result rest -> match rest with 
        | TIMES :: xs -> 
            parse_term xs fail (fun term rest' -> succ (Times (result, term)) rest')
        | _ -> succ result rest
      )
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | [] -> fail ()
    | _ -> parse_literal t fail (fun result rest -> match rest with 
        | POW :: xs -> 
            parse_factor xs fail (fun factor rest' -> succ (Pow (result, factor)) rest')
        | _ -> succ result rest
      )
      
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs -> 
        parse_expr xs 
          (fun () -> fail ()) 
          (fun expr rest -> match rest with 
             | RPAREN :: rest' -> succ expr rest'
             | _ -> fail ())
    | _ -> fail ()
      
  in
  parse_expr input (fun () -> None) (fun x _ -> Some x)
```