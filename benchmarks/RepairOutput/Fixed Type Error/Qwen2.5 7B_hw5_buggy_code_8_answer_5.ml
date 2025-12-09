let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Const 0.0, Const 0.0)) (* Add return values for leaf nodes *)
      | _ -> parse_literal [x] fail (fun () -> parse_expr xs fail return)
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f)
      | VAR -> return (Var)
      | _ -> fail ()
  in parse_expr t (fun () -> failwith "Failed to parse expression") (fun x -> x) (* Return the parsed expression *)