The issue is in the parse_expr function. The call to parse_expr inside the match statement is being used as an expression, but it's a function that needs to be called with more arguments. Here's the fix:

```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun e rest' -> succ (Plus (result, e)) rest')
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    raise NotImplemented
      
  in
  parse_expr input (fun () -> None) (fun x y -> Some x)
```