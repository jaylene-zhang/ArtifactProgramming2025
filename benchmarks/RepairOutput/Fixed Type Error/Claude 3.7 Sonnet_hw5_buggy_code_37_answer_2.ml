The type error is in the recursive call to `parse_expr`. The `succ` function expects to be passed an expression and a list of tokens, but `parse_expr` returns the result of applying `succ` to arguments - not the expression itself.

```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun expr remaining -> 
              succ (Plus (result, expr)) remaining)
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    raise NotImplemented
      
  in
  parse_expr input (fun x -> None) (fun x y -> Some x)
```