```ocaml
(** Question 1 *)

(* TODO: Add test cases. *)
let collect_variables_tests : (formula * Variable_set.t) list = [
  (Conjunction(Variable("x"),Variable("x")),Variable_set.singleton "x");
  (Disjunction (Variable("x"), Negation(Variable("y"))), Variable_set.singleton "x" |> Variable_set.add "y");
  (Conjunction(Variable("x"),Variable("y")),Variable_set.singleton "x" |> Variable_set.add "y");
  (Negation(Conjunction(Variable("x"),Variable("y"))), Variable_set.singleton "x" |> Variable_set.add "y"); 
]

(* TODO: Implement the function. *)
let rec collect_helper (formula : formula) (vars : Variable_set.t): Variable_set.t =
  match formula with 
  | Conjunction (x, y) -> 
      let vars = collect_helper x vars in 
      collect_helper y vars
  | Disjunction (x, y) -> 
      let vars = collect_helper x vars in 
      collect_helper y vars
  | Negation x -> collect_helper x vars
  | Variable s -> Variable_set.add s vars
    
let collect_variables (formula : formula) : Variable_set.t =
  collect_helper formula Variable_set.empty
    

(** Question 2 *)

(* TODO: Add test cases. *)
let eval_success_tests : ((truth_assignment * formula) * bool) list = []

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
```