```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    | [] -> fail ()
    | x :: xs -> parse_term (x :: xs) fail (fun result rest -> 
        match rest with 
        | PLUS :: xs' -> 
          parse_expr xs' fail (fun result2 rest2 -> 
            succ (Plus (result, result2)) rest2)
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail ()
    | x :: xs -> parse_factor (x :: xs) fail (fun result rest ->
        match rest with
        | TIMES :: xs' ->
          parse_term xs' fail (fun result2 rest2 ->
              succ (Times (result, result2)) rest2)
        | _ -> succ result rest
      )

  and parse_factor (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    match t with
    | [] -> fail ()
    | x :: xs -> parse_literal (x :: xs) fail (fun result rest ->
        match rest with
        | POW :: xs' ->
          parse_factor xs' fail (fun result2 rest2 ->
              succ (Pow (result, result2)) rest2)
        | _ -> succ result rest
      )

  and parse_literal (t : token list) (fail : unit -> 'r)
      (succ : exp -> token list -> 'r) : 'r =
    match t with
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ Var xs
    | LPAREN :: xs ->
      (match xs with
       | [] -> fail ()
       | expr_tokens ->
         let rec find_closing_paren tokens count acc =
           match tokens with
           | [] -> None
           | LPAREN :: rest -> find_closing_paren rest (count + 1) (LPAREN :: acc)
           | RPAREN :: rest ->
             if count = 0 then
               Some (List.rev acc, rest)
             else
               find_closing_paren rest (count - 1) (RPAREN :: acc)
           | token :: rest -> find_closing_paren rest count (token :: acc)
         in
         match find_closing_paren expr_tokens 0 [] with
         | Some (inner_tokens, remaining_tokens) ->
           parse_expr inner_tokens fail (fun result rest ->
               match rest with
               | [] ->
                 succ result remaining_tokens
               | _ -> fail ())
         | None -> fail ())
    | _ -> fail ()
  in
  parse_expr input (fun () -> None) (fun x y -> Some x)
```