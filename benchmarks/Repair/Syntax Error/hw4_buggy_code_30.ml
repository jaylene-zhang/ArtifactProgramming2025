(** Question 1 *)

(* TODO: Add test cases. *)
let collect_variables_tests : (formula * Variable_set.t) list = [
  let a,b,c = "a","b","c"
  in
  (Variable a,Variable_set.singleton a);
  
  (Conjunction((Variable a),(Conjunction((Variable b),(Variable c)))),
   Variable_set.singleton "a"
   |>Variable_set.add "b"
   |>Variable_set.add "c");
  
  (Disjunction((Variable a),(Variable b)),
   Variable_set.singleton "a"
   |> Variable_set.add "b");
  
  (Negation(Negation(Negation(Conjunction((Variable a),(Variable b))))),
   Variable_set.singleton "a"
   |>Variable_set.add "b")
  
  

]

(* TODO: Implement the function. *)
let collect_variables (formula : formula) : Variable_set.t =
  let rec func f = 
    match f with
    |Variable a -> Variable_set.singleton a 
    |Negation a -> func a
    |Conjunction(x,y) -> Variable_set.union (func x) (func y)
    |Disjunction(x,y) -> Variable_set.union (func x) (func y)
                           
  in func formula

(** Question 2 *)

(* TODO: Add test cases. *)
let eval_success_tests : ((truth_assignment * formula) * bool) list = [
  let x = "x"
  in
  (true Variable_map.singleton x, true);

]
  

(* TODO: Add test cases. *)
let eval_failure_tests : ((truth_assignment * formula) * exn) list = []

(* TODO: Implement the function. *)
let eval (state : truth_assignment) (formula : formula) : bool =
  raise Not_implemented

(** Question 3 *)

(* TODO: Add test cases. *)
let find_satisfying_assignment_tests : (formula * truth_assignment option) list = []

(* TODO: Implement the function. *)
let find_satisfying_assignment (formula : formula) : truth_assignment =
  raise Not_implemented
