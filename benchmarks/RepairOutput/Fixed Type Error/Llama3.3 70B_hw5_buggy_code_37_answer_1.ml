```
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun e rest' -> succ (Plus (result , e)) rest')
        | _ -> succ result xs
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    raise NotImplemented
      
  in
  parse_expr input (fun x -> None) (fun x y -> Some x)
```
Note: I fixed the code by changing the line `succ (Plus (result , (parse_expr xs fail succ)))` to `parse_expr xs fail (fun e rest' -> succ (Plus (result , e)) rest')` to correctly pass the continuation `succ` to the recursive call to `parse_expr`.