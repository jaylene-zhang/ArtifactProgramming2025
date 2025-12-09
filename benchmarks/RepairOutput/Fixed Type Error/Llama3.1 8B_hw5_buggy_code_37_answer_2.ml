```haskell
let parser_cps input : exp option =
  let rec parse_expr (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r = 
    match t with
    | [] -> fail()
    | x :: xs -> parse_factor [x] fail (fun result rest -> parse_expr rest fail succ)
      
  and parse_factor (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: xs -> parse_term t fail succ
      
  and parse_term (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with
    | x :: PLUS :: xs -> parse_expr xs fail (fun result rest -> Plus (result , (parse_term rest fail succ)))
    | x :: xs -> parse_factor xs fail succ
      
  and parse_literal (t : token list) (fail : unit -> 'r) (succ : exp -> token list -> 'r) : 'r =
    match t with 
    | FLOAT x :: xs -> succ (Const x) xs
    | VAR :: xs -> succ (Var) xs
    | LPAREN :: x :: RPAREN :: xs -> parse_expr xs fail succ
    | _ -> fail ()
      
  in
  parse_expr input (fun x -> None) (fun x y -> Some x)
```