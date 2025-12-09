```haskell
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> parse_term t fail (fun result rest -> match rest with 
        | PLUS :: rest -> succ (Plus (result, (parse_expr rest fail succ)))
        | _ -> succ (result, xs) )
  
  and parse_term (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> parse_factor t fail (fun result rest -> match rest with 
        | TIMES :: rest -> succ (Times (result, (parse_term rest fail succ)))
        | _ -> succ (result, xs) )
      
  and parse_factor (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | [] -> fail()
    | x :: xs -> parse_literal t fail (fun result rest -> match rest with 
        | POW :: rest -> succ (Pow (result, (parse_factor rest fail succ)))
        | _ -> succ (result, xs) )
      
  and parse_literal (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with 
    | x :: xs -> match x with
        | FLOAT x -> succ (Const x) xs
        | VAR -> succ (Var) xs
        | LPAREN :: x :: RPAREN -> succ (Plus ((parse_expr [x] fail succ), (parse_expr [] fail succ))) xs
        | _ -> fail ()
      
      
  in
  
  parse_expr input (fun x -> None) (fun x y -> Some x)
      
let check_parser t v = match parser_cps t with
  | None -> None
  | Some(e) -> Some(eval e v)
```