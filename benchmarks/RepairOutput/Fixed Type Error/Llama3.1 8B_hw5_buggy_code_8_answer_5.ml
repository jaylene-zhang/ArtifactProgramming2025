```ocaml
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var))
      | _ -> return (Var) (* Annotated return with a type *)
  and parse.OrdinalIgnoreCaseLiteral (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f)
      | VAR -> return (Var)
      | _ -> fail ()
  in parse_expr t (fun () -> None) (fun x -> Some x)
```