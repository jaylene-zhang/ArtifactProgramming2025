(** Question 1 *)


let form1 = parse_formula "(a3 | ~b) & c" 
    
let form1set : Variable_set.t
  =  Variable_set.singleton "a3"
     |> Variable_set.add "b"
     |> Variable_set.add "c";;


let form2 = parse_formula "~ ( ~ ( ~ ((a & b ) & c )))"
  
let form2set : Variable_set.t
  =  Variable_set.singleton "a" 
     |> Variable_set.add "b"
     |> Variable_set.add "c";;


(* TODO: Add test cases. *)
let collect_variables_tests : (formula * Variable_set.t) list = [(form1, form1set); (form2, form2set)]

(* TODO: Implement the function. *) 
  
let collect_variables (formula : formula) : Variable_set.t = 
  
  let rec helper acc (formula : formula) : Variable_set.t = match formula with
    | Variable (c) ->  acc |> Variable_set.add c
    | Conjunction ( form1, form2 ) ->  helper (helper acc form1) form2
    | Disjunction (  form1, form2 ) -> helper (helper acc form1) form2
    | Negation (form) -> helper acc form
  in
  
  helper Variable_set.empty formula
  
                             
(** Question 2 *)

(* TODO: Add test cases. *)

let abcde_truth_asgn : truth_assignment
  =  Variable_map.singleton "a" true
     |> Variable_map.add       "b" false
     |> Variable_map.add       "c" false
     |> Variable_map.add       "d" false
     |> Variable_map.add       "e" false 
       
let form3 = parse_formula "a | (b | (c | (d | e)))" 
       
let abcd_truth_asgn : truth_assignment
  =  Variable_map.singleton "a" true
     |> Variable_map.add       "b" false
     |> Variable_map.add       "c" false
     |> Variable_map.add       "d" false 
  
       
let eval_success_tests : ((truth_assignment * formula) * bool) list = [(( abcde_truth_asgn ,form2), true); (( abcde_truth_asgn, form3), true)]

(* TODO: Add test cases. *)
let eval_failure_tests : ((truth_assignment * formula) * exn) list = [ (( abcd_truth_asgn, form3), Unassigned_variable "e")]

(* TODO: Implement the function. *)

let eval (state : truth_assignment) (formula : formula) : bool =
  
  let rec helper acc (state : truth_assignment) (formula : formula) : bool = match formula with
    | Variable (c) -> 
        (match (Variable_map.find_opt c state) with 
         | Some v -> v
         | None -> raise (Unassigned_variable c) ) 
  
    | Conjunction ( form1, form2 ) -> 
        let x = (helper acc state form1) in
        let y = helper acc state form2 in
        x && y
  
    | Disjunction (  form1, form2 ) ->  
        let x = (helper acc state form1) in
        let y = (helper acc state form2) in
        x || y
    
    | Negation (form) ->  not(helper acc state form) 
                            
  in 
  helper false state formula
  

(** Question 3 *)

(* TODO: Add test cases. *)

let form4 = parse_formula "x & ~x"
    
let form5 = parse_formula "~ ( ~ ((~a) & b ))" 
    
let ab_truth_asgn : truth_assignment 
  =  Variable_map.singleton "a" false
     |> Variable_map.add       "b" true
       
  
let find_satisfying_assignment_tests : (formula * truth_assignment option) list = [(form5, Some ab_truth_asgn); (form4, None)]

                 
let initial_map (formula: formula) = 
  let variables_list = Variable_set.elements (collect_variables formula) in
  let mapped : truth_assignment  = Variable_map.empty in 
  let rec helper list acc =  
    match list with 
    | [] -> acc 
    | (x :: xs) -> 
        
        helper xs (acc |> Variable_map.add x false) 
        
  in helper variables_list mapped


let find_satisfying_assignment (formula : formula) : truth_assignment = 
  let acc : truth_assignment  = initial_map formula in
  
  let rec helper (acc: truth_assignment) (variables) : truth_assignment = match variables with
    
    | _ when (eval acc formula == true)  ->  acc
    | [] -> raise Unsatisfiable_formula
    | x :: xs when List.mem_assoc false [false, false ] -> 
        helper (acc |> Variable_map.remove x |> Variable_map.add x true) xs
    | x :: xs -> 
        try
          helper acc xs
        with 
        | Unsatisfiable_formula -> helper (acc |> Variable_map.remove x |> Variable_map.add x false) xs
  
  in 
  helper acc (Variable_set.elements (collect_variables formula))
    
    
let cab = variable_map_to_list (find_satisfying_assignment form2)
  
  
  
  
  
  
