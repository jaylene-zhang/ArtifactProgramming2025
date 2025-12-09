```ocaml
let to_int (n : 'b church) : int = 
  let rec helper a = match a with
    | x -> 0
  in
  helper n
```

The error is due to the incorrect pattern matching on `n` inside the `helper` function. Since `n` is of type `int church`, you don't need to destructure it as if it were a tuple. The `helper` function should directly return 0 when called with `n`.

However, the approach to directly return 0 without correctly evaluating the Church numeral is not correct. Below is a correct implementation of `to_int` for Church numerals:

```ocaml
let to_int (n : 'b church) : int = 
  let rec helper (f : 'b -> 'b) (x : 'b) : int = 
    match n with
    | zero -> 0
    | one -> 1
    | s -> 1 + (helper s f x)
  in
  helper (fun x -> x + 1) 0
```

This implementation correctly evaluates the Church numeral `n` by recursively applying the successor function to 0.