```ocaml
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> parse_expr xs fail (fun expr xs -> return (Plus expr expr))
      | _ -> parse_literal [x] fail (fun expr xs -> parse_expr xs fail (fun expr' xs -> return expr' xs))
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f) xs
      | VAR -> return (Var) xs
      | _ -> fail ()
  in parse_expr t (fun () -> None) (fun x xs -> Some x)
```