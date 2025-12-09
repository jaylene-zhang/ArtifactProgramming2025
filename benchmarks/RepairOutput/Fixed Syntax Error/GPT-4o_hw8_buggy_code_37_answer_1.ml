```ocaml
(* TODO: Q1a *) 
let rec take (n : int) (s : 'a stream) : 'a list = 
  match n with
  | 0 -> []
  | _ -> s.head :: take (n - 1) (s.tail ())

(* TODO: Q1b *)
let rec drop (n : int) (s : 'a stream) : 'a stream = 
  match n with
  | 0 -> s
  | _ -> drop (n - 1) (s.tail ())

(* TODO: Q2a *)
let zeroes : int stream =
  unfold (fun a -> (0, a)) 0

(* TODO: Q2b *)
let natural_numbers : int stream =
  unfold (fun a -> (a, a + 1)) 0

(* TODO: Q2c *)
let even_numbers : int stream =
  unfold (fun a -> (a, a + 2)) 0

(* TODO: Q3 *)
let map2 (f : 'a -> 'b -> 'c) (s1 : 'a stream) (s2 : 'b stream) : 'c stream =
  {
    head = f s1.head s2.head;
    tail = fun () -> map2 f (s1.tail ()) (s2.tail ())
  }

(* TODO: Q4a *)
let fibonacci : int stream =
  let rec fib a b =
    {
      head = a;
      tail = fun () -> fib b (a + b)
    }
  in
  fib 0 1

(* TODO: Q4b *)
let lucas : int stream =
  let rec luc a b =
    {
      head = a;
      tail = fun () -> luc b (a + b)
    }
  in
  luc 2 1
```