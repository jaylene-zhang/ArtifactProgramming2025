(** Question 1 *)

(* TODO: Add test cases. *)
let oneVar : Variable_set.t =  Variable_set.singleton "a"
let twoVarsCaps : Variable_set.t =  Variable_set.singleton "a" |> Variable_set.add "A"
let twoVars : Variable_set.t =  Variable_set.singleton "a" |> Variable_set.add "b"
let threeVars : Variable_set.t =  Variable_set.singleton "a" |> Variable_set.add "b" |> Variable_set.add "c"
let collect_variables_tests : (formula * Variable_set.t) list = [
  ((Variable("a")),oneVar);
  ((Conjunction(Variable("a"), Variable("a"))), oneVar); (*Duplicate*)
  ((Conjunction(Variable("a"), Variable("b"))), twoVars); (*Two Vars*)
  (Negation(Negation((Negation(Variable("a"))))), oneVar); (*Triple Negation*)
  ((Conjunction(Variable("a"), Disjunction(Variable("a"), Variable("b")))), twoVars); (*Nested*) 
  ((Conjunction(Variable("A"), Variable("a"))), twoVarsCaps); (*Caps*)
  ((Negation(Disjunction(Variable("A"), Variable("a")))), twoVarsCaps); (*Nested1*)
  ((Conjunction(Negation(Variable("A")), Variable("a"))), twoVarsCaps); (*Nested2*)
  ((Conjunction(Variable("a"), Disjunction(Negation(Variable("c")), Negation(Variable("b"))))), threeVars); (*Nested*) 
]

(* TODO: Implement the function. *)
let collect_variables (formula : formula) : Variable_set.t =
  let rec helper (f : formula) (ans: Variable_set.t) = match f with
    | Variable s -> Variable_set.add s ans
    | Conjunction (f1, f2) ->  
        let a = helper(f1) (ans) in 
        let b = helper(f2) (ans) in
        let c = Variable_set.union a b in
        Variable_set.union ans c
    | Disjunction (f1, f2) -> 
        let a = helper(f1) (ans) in
        let b = helper(f2) (ans) in
        let c = Variable_set.union a b in
        Variable_set.union ans c
    | Negation f1 -> 
        let a = helper(f1) (ans) in
        Variable_set.union ans a
  in 
  let listOfVars = helper formula Variable_set.empty in
  listOfVars

(** Question 2 *)

let map1 = Variable_map.singleton "x" true
           |> Variable_map.add       "y" false 
let map2 = Variable_map.singleton "a" false
           |> Variable_map.add       "b" false 
           |> Variable_map.add       "c" false 
let formula1_normal = Variable("x")
let formula1_cap = Variable("X")
let formula1_negation = Negation(Variable("x"))
let formula2_conjunction = Conjunction(Variable("x"), Variable("y"))
let formula2_disjunction = Disjunction(Variable("x"), Variable("y"))
let formula2_negatedisjunction = Disjunction(Negation(Variable("x")), Variable("y"))
let formula3_complex = Conjunction(Variable("a"), Disjunction(Negation(Variable("c")), Negation(Variable("b"))))
let formula3_complex_capped = Conjunction(Variable("a"), Disjunction(Negation(Variable("c")), Negation(Variable("B"))))
(* TODO: Add test cases. *)
let eval_success_tests : ((truth_assignment * formula) * bool) list = [
  ((map1, formula1_normal), true);
  ((map1, formula2_conjunction), false);
  ((map1, formula2_disjunction), true);
  ((map1, formula2_negatedisjunction), false);
  ((map1, formula1_negation), false);
  ((map2, formula3_complex), false);
]

(* TODO: Add test cases. *)
let eval_failure_tests : ((truth_assignment * formula) * exn) list = [
  ((map1, formula1_cap), Unassigned_variable "X");
  ((map2, formula3_complex_capped), Unassigned_variable "B")
]

(* TODO: Implement the function. *)
let rec  eval (state : truth_assignment) (f : formula) : bool = match f with 
  | Conjunction (f1, f2) ->  
      let a = eval state f1 in
      let b = eval state f2 in
      a && b
  | Disjunction (f1, f2) -> 
      let a = eval state f1 in
      let b = eval state f2 in 
      a || b
  | Negation f1 -> 
      let a = eval state f1 in
      not a
  | Variable s -> 
      let optionResult = Variable_map.find_opt s state in
      match optionResult with
      | Some x -> x
      | None -> raise (Unassigned_variable s)
       
let merge = (fun k xo yo -> match xo,yo with
    | Some x, Some _ -> Some x
    | _ -> None
  )
  
let collect_variables_with_true (formula : formula) : truth_assignment =
  let rec helper (f : formula) (ans: truth_assignment) = match f with
    | Variable s -> Variable_map.add s true ans
    | Conjunction (f1, f2) ->  
        let a = helper(f1) (ans) in 
        let b = helper(f2) (ans) in
        let c = Variable_map.merge (merge) a b in
        Variable_map.merge (merge) ans c
    | Disjunction (f1, f2) -> 
        let a = helper(f1) (ans) in
        let b = helper(f2) (ans) in
        let c = Variable_map.merge (merge)  a b in
        Variable_map.merge (merge) ans c
    | Negation f1 -> 
        let a = helper(f1) (ans) in
        Variable_map.merge (merge) ans a
  in 
  let listOfVars = helper formula Variable_map.empty in
  listOfVars
(** Question 3 *)

let formula1_normal = Variable("x")

let formula1_negation = Negation(Variable("x"))
let formula2_conjunction = Conjunction(Variable("x"), Variable("y"))
    
    
let oneTrue = Some(Variable_map.singleton "x" true)
let oneFalse = Some(Variable_map.singleton "x" false)
let twoTrue = Some(Variable_map.singleton "x" true |> Variable_map.add       "y" true )
(* TODO: Add test cases. *)
let find_satisfying_assignment_tests : (formula * truth_assignment option) list = [
  (formula1_normal, oneTrue);
  (formula1_negation, oneFalse);
  (formula2_conjunction, twoTrue);
]

(* TODO: Implement the function. *)
let find_satisfying_assignment (formula : formula) : truth_assignment =
  let allVars = collect_variables_with_true(formula) in
  (*let state = Variable_map.empty in
   let map setName =
     Variable_set.fold (fun x -> Variable_map.add x true state) setName empty in
   let result = map allVars in
   state
  let addToMap s = Variable_map.add s true map in
  let a = Variable_set.map (addToMap) allVars in
  map
  *)
  allVars
