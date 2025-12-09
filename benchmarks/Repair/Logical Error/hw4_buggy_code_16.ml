(** Question 1 *)

(* TODO: Add test cases. *)
let form = parse_formula "x"
let empty : Variable_set.t = Variable_set.empty
let one_var : Variable_set.t = Variable_set.singleton "x"
let two_var : Variable_set.t = Variable_set.singleton "x" |> Variable_set.add "y"
let three_var : Variable_set.t = Variable_set.singleton "x" |> Variable_set.add "y" |> Variable_set.add "z"

let collect_variables_tests : (formula * Variable_set.t) list = [ 
  (parse_formula "x", one_var);
  (* Variable "x", one_var);
  (Negation (Variable "x"), one_var);
  (Negation (Variable ""), empty);
  (Negation (Negation (Variable "x")), one_var);
  (Conjunction (Variable "",  Variable ""), empty);
  (Disjunction (Variable "",  Variable "x"), one_var);
  (Disjunction (Variable "x",  Variable "y"), two_var);
  (Conjunction (Negation( Variable "x"),  Variable "y"), two_var);
  (Conjunction (Negation( Variable "x"),  Disjunction(Variable "y", Variable "z")), three_var); *)
]

(* TODO: Implement the function. *)
let rec collect_variables (formula : formula) : Variable_set.t = match formula with
  | Variable x -> Variable_set.singleton x
  | Negation form -> collect_variables form
  | Conjunction (form1, _) -> collect_variables form1
  | Disjunction (form1, _) -> collect_variables form1

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