The issue is in the parse_expr function where you're trying to use the parse_expr result directly as an expression. However, parse_expr is a function that needs to be called with the proper arguments.

```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> 
        match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun result' rest' ->
              succ (Plus (result, result')) rest'
            )
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    raise NotImplemented
      
  in
  parse_expr input (fun () -> None) (fun x y -> Some x)
```