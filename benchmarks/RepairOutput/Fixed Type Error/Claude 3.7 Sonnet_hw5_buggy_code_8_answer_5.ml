The type error is in the `parse_literal` call. The second argument to `return` should be the remaining tokens, not a function. Also, `ys` is undefined. Here's the fixed code:

```ocaml
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var)) xs
      | _ -> parse_literal input fail (fun e rest -> parse_expr rest fail return)
                   (*and parse_term (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
                      failwith "todo!"
  and parse_factor (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    failwith "todo!" *)
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f) xs
      | VAR -> return Var xs
      | _ -> fail ()
  in parse_expr t (fun () -> None) (fun x _ -> Some x)
```