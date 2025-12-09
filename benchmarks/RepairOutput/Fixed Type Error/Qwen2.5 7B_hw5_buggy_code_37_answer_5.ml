let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs when x = PLUS -> parse_term [x] fail (fun result rest -> succ (Plus (result, (parse_expr xs fail succ))))
    | x :: xs -> parse_term [x] fail (fun result rest -> succ result rest)
 
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with
    | x :: xs when x = TIMES -> parse_factor [x] fail (fun result rest -> succ (Times (result, (parse_term xs fail succ))))
    | x :: xs -> parse_factor [x] fail succ
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with
    | x :: xs when x = POW -> parse_literal [x] fail (fun result rest -> succ (Pow (result, (parse_factor xs fail succ))))
    | x :: xs -> parse_literal [x] fail succ
      
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ (Var) xs
    | LPAREN :: xs -> parse_expr xs fail succ
    | _ -> fail ()
    
  in
  
  parse_expr input (fun x -> None) (fun x y -> Some x)
  
let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)