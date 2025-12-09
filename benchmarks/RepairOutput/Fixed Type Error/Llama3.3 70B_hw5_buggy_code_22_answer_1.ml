```ocaml
let parser_cps (t : token list) : exp =
  let rec expr tl (cont: token list -> exp -> exp) (fail: unit -> 'a) =
    let nsc t e =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | PLUS -> Plus(e, expr xs cont fail)
          | _ -> cont e t
    in

    helper2 tl nsc (fun () -> fail ()) fail

  and helper2 tl (cont: exp -> token list -> exp) (fail: unit -> 'a) (failer: unit -> 'a) =
    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | TIMES -> Times(e, expr xs cont failer)
          | _ -> cont e t
    in

    helper1 tl nsc (fun () -> failer ()) failer

  and helper1 tl (cont: exp -> token list -> exp) (fail: unit -> 'a) (failer: unit -> 'a) =

    let nsc e t =
      match t with
      | [] -> e
      | x :: xs ->
          match x with
          | POW -> Pow(e, expr xs cont failer)
          | _ -> cont e t
    in

    factor tl nsc (fun () -> failer ()) failer

  and factor tl (cont: exp -> token list -> exp) (fail: unit -> 'a) (failer: unit -> 'a) =
    match tl with
    | [] -> raise NotFound 
    | x :: xs ->
        match x with
        | FLOAT x -> cont (Const(x)) xs
        | VAR -> cont Var xs
        | LPAREN -> expr xs cont failer
        | RPAREN -> raise NotFound 
        | _ -> failer ()
  in
    
  
  expr t (fun a b -> a) (fun () -> assert false)


(*let check_parser t v =
   match parser_cps t with
   | None -> None
   | Some(e) -> Some(eval e v)*)
```