The issue is in the function call to `parse_literal`. The signature of `parse_literal` expects a `return` function of type `exp -> token list -> 'r`, but you're passing `fun () -> parse_expr ys fail return` which has type `unit -> 'r`.

Here's the fixed code:

```ocaml
let parse_cps t =
  let rec parse_expr (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | PLUS -> return (Plus (Var, Var)) xs
      | _ -> parse_literal input fail (fun e remaining -> parse_expr remaining fail return)
                   
  and parse_literal (input : token list) (fail : unit -> 'r) (return : exp -> token list -> 'r) : 'r =
    match input with
    | [] -> fail ()
    | x :: xs -> match x with
      | FLOAT f -> return (Const f) xs
      | VAR -> return Var xs
      | _ -> fail ()
  in parse_expr t (fun () -> None) (fun x _ -> Some x)
```