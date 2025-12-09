```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | PLUS :: x :: xs -> 
        parse_term [x] fail (fun result rest -> 
            match rest with 
            | PLUS :: xs -> 
                succ (Plus (result , (parse_expr xs fail succ)))
            | _ -> result
        )
    | _ :: xs -> parse_term t fail succ
  
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with
    | TIMES :: x :: xs -> 
        parse_factor [x] fail (fun result rest -> 
            match rest with 
            | TIMES :: xs -> 
                succ (Times (result , (parse_term xs fail succ)))
            | _ -> result
        )
    | _ :: xs -> parse_factor t fail succ
  
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | POW :: x :: xs -> 
        parse_literal [x] fail (fun result rest -> 
            match rest with 
            | POW :: xs -> 
                succ (Pow (result , (parse_factor xs fail succ)))
            | _ -> result
        )
    | _ :: xs -> parse_factor t fail succ
  
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ (Var) xs
    | LPAREN :: x :: RPAREN :: xs -> parse_expr [x] fail succ
    | _ -> fail ()
      
  in
  
  parse_expr input (fun x -> None) (fun x y -> Some x)
  
let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)
```