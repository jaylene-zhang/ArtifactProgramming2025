The issue is that in the match case for `PLUS` in `parse_expr`, you're trying to use the result of calling `parse_expr` directly, but `parse_expr` returns a CPS-transformed result that needs to be threaded into the success continuation.

```ocaml
let parser_cps input : exp option =
  
  let rec parse_expr (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    match t with 
    |[] -> fail()
    | x :: xs -> parse_term [x] fail (fun result rest -> match rest with 
        | PLUS :: xs -> 
            parse_expr xs fail (fun result2 rest2 -> 
              succ (Plus (result, result2)) rest2)
        | _ -> succ result rest
      )  
 
      
  and parse_term (t : token list) (fail : unit -> 'r) 
      (succ : exp -> token list -> 'r) : 'r = 
    
    raise NotImplemented
      
  in
  parse_expr input (fun () -> None) (fun x y -> Some x)
```