```haskell
let rec parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> parse_term xs fail return
      | _ -> return (makeVar x) (parse_literal xs fail return)
  and parse_term (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: _ -> match x with
      | TIMES -> makeVar x (parse_factor xs fail return)
      | RPAREN -> fail ()
      | _ -> fail ()
  and parse_factor (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | LPAREN :: xs ->
      let x = parse_expr xs (fun () -> fail ()) (fun e -> RPAREN :: xs)
      in (return e) xs
    | _ -> parse_literal input fail return
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> (return (Const f)) xs
      | VAR -> (return (Var)) xs
      | _ -> fail ()
  and makeVar x e expr = match e with
    | Some e -> e
    | None -> (Var, x)
  and cons x xs = x :: xs
  and rec_is_empty l =
    match l with
    | [] -> true
    | _ :: _ -> false
in parse_expr t (fun () -> None) (fun x -> Some x)
```