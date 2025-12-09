(** Question 1 *)

(* TODO: Add test cases. *)
let collect_variables_tests : (formula * Variable_set.t) list = [
  ( (parse_formula "a | b"), (Variable_set.singleton "a" 
                              |> Variable_set.add "b") );
]

(* TODO: Implement the function. *)
let collect_variables (formula : formula) : Variable_set.t =
  raise Not_implemented

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
