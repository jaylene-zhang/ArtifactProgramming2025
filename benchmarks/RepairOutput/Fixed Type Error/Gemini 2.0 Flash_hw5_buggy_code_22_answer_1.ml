```ocaml
let parser_cps (t : token list) = 
  let rec expr tl sc fc =
    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | PLUS -> expr xs (fun e2 -> sc (Plus(e, e2))) fc
          | _ -> sc e
    in

    helper2 tl nsc fc

  and helper2 tl sc fc =
    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | TIMES -> expr xs (fun e2 -> sc (Times(e, e2))) fc
          | _ -> sc e
    in

    helper1 tl nsc fc

  and helper1 tl sc fc =

    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | POW -> expr xs (fun e2 -> sc (Pow(e, e2))) fc
          | _ -> sc e
    in

    factor tl nsc fc

  and factor tl sc fc =
    match tl with
    | [] -> raise NotFound 
    | x :: xs ->
        match x with
        | FLOAT x -> sc (Const(x)) xs
        | VAR -> sc Var xs
        | LPAREN -> expr xs sc (fun () -> raise NotFound)
        | RPAREN -> raise NotFound 
        | _ -> fc ()
  in
    
  
  expr t (fun e -> e) (fun () -> raise NotFound)
```