```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term t fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun right_expr rest' -> succ (Plus (result, right_expr)) rest')
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> parse_factor t fail (fun result rest -> match rest with
        | TIMES :: xs -> 
            parse_term xs fail (fun right_term rest' -> succ (Times (result, right_term)) rest')
        | _ -> succ result rest
      )
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r =
    match t with
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs -> 
      parse_expr xs fail (fun result rest -> 
        match rest with
        | RPAREN :: rest' -> succ result rest'
        | _ -> fail ()
      )
    | _ -> fail ()
      
  in
  parse_expr input (fun () -> None) (fun x _ -> Some x)
```