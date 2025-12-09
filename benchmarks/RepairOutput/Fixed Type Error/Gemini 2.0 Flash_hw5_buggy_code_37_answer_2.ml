```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | [] -> fail ()
    | x :: xs -> parse_term (x :: xs) fail (fun result rest -> 
        match rest with
        | PLUS :: rest_of_rest -> 
            parse_expr rest_of_rest fail (fun result2 rest2 ->
                succ (Plus (result, result2)) rest2
            )
        | _ -> succ result rest
      )
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    parse_factor t fail (fun result rest ->
        match rest with
        | TIMES :: rest_of_rest ->
            parse_term rest_of_rest fail (fun result2 rest2 ->
                succ (Times (result, result2)) rest2
            )
        | _ -> succ result rest
    )
    
  and parse_factor (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    
    parse_literal t fail (fun result rest ->
        match rest with
        | POW :: rest_of_rest ->
            parse_factor rest_of_rest fail (fun result2 rest2 ->
                succ (Pow (result, result2)) rest2
            )
        | _ -> succ result rest
    )
    
  and parse_literal (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    match t with
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs -> 
        parse_expr xs fail (fun result rest ->
            match rest with
            | RPAREN :: rest_of_rest -> succ result rest_of_rest
            | _ -> fail ()
        )
    | _ -> fail ()
      
  in
  parse_expr input (fun () -> None) (fun x y -> Some x)
```