```
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'a) (succ : exp -> token list -> 'a) : 'a = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term x xs fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            succ (Plus (result , (parse_expr xs fail succ)))
        | _ -> result
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'a) 
      (succ : exp -> token list -> 'a) : 'a = 
      
    parse_literal t fail succ
    
  and parse_literal (t : token list) (fail : unit -> 'a) 
      (succ : exp -> token list -> 'a) : 'a =  
    
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