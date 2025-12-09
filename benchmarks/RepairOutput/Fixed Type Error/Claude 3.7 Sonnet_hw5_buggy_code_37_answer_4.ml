The issue is in the `parse_expr` function. When parsing `PLUS`, you're calling `parse_expr` directly as an expression, but `parse_expr` expects to be called with arguments and returns a value via the CPS style.

```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> 
        match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun expr remaining -> 
              succ (Plus (result, expr)) remaining)
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    raise NotImplemented
      
  in
  parse_expr input (fun () -> None) (fun x y -> Some x)
```