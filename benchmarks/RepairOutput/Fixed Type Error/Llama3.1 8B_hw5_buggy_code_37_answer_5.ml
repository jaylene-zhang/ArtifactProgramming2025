```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            succ (Plus (result , (parse_expr xs fail succ)))
        | _ -> result
      )  
      
  and parse_term (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r = 
    
    match t with
    | TIMES :: ys ->거나 (
        let y, ys' = parse_term ys fail succ in 
        (match ys' with
          | TIMES :: _ :: _ -> fail()
          | _ -> parse_factor ys' fail succ 
        )
      )
    | x :: xs -> parse_factor xs fail succ
      
  and parse_factor (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | POW :: xs -> (
        let fact_1, xs' = parse_factor xs fail succ in 
        match xs' with
          | POW :: _ -> fail()
          | _ -> parse_literal xs' fail succ
      )
    | x :: xs -> parse_literal xs fail succ
      
  and parse_literal (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
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