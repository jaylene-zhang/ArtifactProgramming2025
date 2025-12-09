Here is the fixed code:


```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun result2 rest2 -> succ (Plus (result, result2)) rest2)
        | _ -> succ result xs
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | x :: TIMES :: xs -> parse_factor [x] fail (fun result rest -> parse_term xs fail (fun result2 rest2 -> succ (Times (result, result2)) rest2))
    | x :: xs -> parse_factor t fail succ
      
  and parse_factor (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: POW :: xs -> parse_literal [x] fail (fun result rest -> parse_factor xs fail (fun result2 rest2 -> succ (Pow (result, result2)) rest2))
    | x :: xs -> parse_literal t fail succ
      
  and parse_literal (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ (Var) xs
    | LPAREN :: x :: RPAREN :: xs -> parse_expr [x] fail succ
    | _ -> fail ()
      
      
  in
  
  parse_expr input (fun x -> None) (fun x y -> Some x)
      
(*
    match parser_cps input with
    | None -> None
    | Some(e) -> Some(eval e x)
 *)
let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)
```