let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r =
    
    match t with 
    |[] -> fail()
    | x :: xs -> 
        (match x with 
          | PLUS :: xs' -> 
              parse_term (x :: xs) fail (fun result rest -> succ (Plus (result , (parse_expr rest fail succ))))
          | _ -> 
              parse_term [x] fail (fun result rest -> succ result rest))
 
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | x :: TIMES :: xs -> 
        parse_factor (x :: xs) fail (fun result rest -> succ (Times (result , (parse_term rest fail succ))))
    | x :: xs -> 
        parse_factor [x] fail (fun result rest -> succ result rest)
      
  and parse_factor (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | x :: POW :: xs -> 
        parse_literal (x :: xs) fail (fun result rest -> succ (Pow (result , (parse_factor rest fail succ))))
    | x :: xs -> 
        parse_factor [x] fail (fun result rest -> succ result rest)
      
  and parse_literal (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ (Var) xs
    | LPAREN :: x :: RPAREN :: xs -> 
        parse_expr [x] fail (succ)
    | _ -> fail ()
      
  in
  parse_expr input (fun x -> None) (fun x y -> Some x)
  
let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)