let parse_cps t =
  let rec parse_expr (input : token list)
      (fail : unit -> 'r)
      (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs ->
      (match x with
       | PLUS -> return (Plus (Var, Var)) xs
       | _ -> parse_literal (x :: xs) fail (fun e rest -> parse_expr rest fail return))
  and parse_literal (input : token list)
      (fail : unit -> 'r)
      (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs ->
      (match x with
       | FLOAT f -> return (Const f) xs
       | VAR -> return Var xs
       | _ -> fail ())
  in
  parse_expr t (fun () -> None) (fun e rest -> Some (e, rest))