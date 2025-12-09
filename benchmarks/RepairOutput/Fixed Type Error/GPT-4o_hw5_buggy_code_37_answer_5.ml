```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term t fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun next_exp remaining -> succ (Plus (result, next_exp)) remaining)
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | _ -> parse_factor t fail (fun result rest -> match rest with
        | TIMES :: xs -> 
            parse_term xs fail (fun next_exp remaining -> succ (Times (result, next_exp)) remaining)
        | _ -> succ result rest
      )
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | _ -> parse_literal t fail (fun result rest -> match rest with
        | POW :: xs -> 
            parse_factor xs fail (fun next_exp remaining -> succ (Pow (result, next_exp)) remaining)
        | _ -> succ result rest
      )
      
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs -> 
        parse_expr xs fail (fun exp rest -> match rest with
            | RPAREN :: remaining -> succ exp remaining
            | _ -> fail ()
        )
    | _ -> fail ()
      
  in
  
  parse_expr input (fun () -> None) (fun x y -> Some x)
```