The issue is in the callback function for `parse_literal` - it doesn't match the expected type. Here's the fixed code:

```ocaml
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var)) xs
      | _ -> parse_literal input fail (fun e ys -> parse_expr ys fail return)
                   
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f) xs
      | VAR -> return Var xs
      | _ -> fail ()
  in parse_expr t (fun () -> None) (fun x _ -> Some x)
```