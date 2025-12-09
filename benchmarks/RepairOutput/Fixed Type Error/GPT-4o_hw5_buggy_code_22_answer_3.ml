```ocaml
let parser_cps (t : token list) = 
  let rec expr tl sc fc =
    let nsc t e =
      match t with
      | [] -> sc e []
      | x :: xs ->
          match x with
          | PLUS -> expr xs (fun e' tl' -> sc (Plus(e, e')) tl') fc
          | _ -> sc e t
    in

    helper2 tl nsc fc

  and helper2 tl sc fc =
    let nsc e t =
      match t with
      | [] -> sc e []
      | x :: xs ->
          match x with
          | TIMES -> expr xs (fun e' tl' -> sc (Times(e, e')) tl') fc
          | _ -> sc e t
    in

    helper1 tl nsc fc

  and helper1 tl sc fc =
    let nsc e t =
      match t with
      | [] -> sc e []
      | x :: xs ->
          match x with
          | POW -> expr t (fun e' tl' -> sc (Pow(e, e')) tl') fc
          | _ -> sc e t
    in

    factor tl nsc fc

  and factor tl sc fc =
    match tl with
    | [] -> fc ()
    | x :: xs ->
        match x with
        | FLOAT x -> sc (Const x) xs
        | VAR -> sc Var xs
        | LPAREN -> expr xs (fun e tl' ->
                                match tl' with
                                | RPAREN :: xs' -> sc e xs'
                                | _ -> fc ()) fc
        | RPAREN -> fc ()
        | _ -> fc ()
  in
    
  expr t (fun e _ -> e) (fun () -> raise NotFound)
```