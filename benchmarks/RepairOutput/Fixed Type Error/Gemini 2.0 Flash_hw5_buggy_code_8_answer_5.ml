```ocaml
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var)) xs
      | _ -> parse_literal input fail (fun e -> fun ys -> return e ys)
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f) x
      | VAR -> return (Var) x
      | _ -> fail ()
  in parse_expr t (fun () -> None) (fun x xs -> Some x)
```