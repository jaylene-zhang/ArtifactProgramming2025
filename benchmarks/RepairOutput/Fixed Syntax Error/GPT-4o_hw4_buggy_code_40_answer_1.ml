```ocaml
(* Question 1 *)
let formula1 = parse_formula "a&(a|~b)";;
let formula2 = parse_formula "~~a";;
let formula3 = parse_formula "a1|a2|a3";;
let formula4 = parse_formula "a";;
let formula5 = parse_formula "(a&b)|(c&~d)";;
let formula6 = parse_formula "a|b&~c|d|e|f|g";;
let formula7 = parse_formula "a&b";;
let formula8 = parse_formula "a|b";;
let formula9 = parse_formula "~a";;
let formula10 = parse_formula "~a&a";;
let formula11 = parse_formula "(((~a|a)&(c|g))|((b)|(d)))&(((~z&p)&(y|~h))|((x|u)|(w&v)))";;
let formula12 = parse_formula "~(a|a)";;
let formula13 = parse_formula "a&a";;
let formula14 = parse_formula "x&~y";;
let formula15 = parse_formula "x&~x";;
let formula16 = parse_formula "~(~(~(a)))";;
let formula17 = parse_formula "a&b";;

let formula18 = parse_formula "a";;
let formula19 = parse_formula "a&a";;
let formula20 = parse_formula "a&b";;
let formula21 = parse_formula "~(~(~(a)))";;
let formula22 = parse_formula "(a)&(a|b)";;
let formula23 = parse_formula "(A)&(a)";;
let formula24 = parse_formula "~(A|a)";;
let formula25 = parse_formula "(~A)&(a)";; 
let formula26 = parse_formula "~(b|(a&b)&a|(b|(a&b)))";; 
let formula27 = parse_formula "a|~a";;
let formula28 = parse_formula "~(a&b)";;

let set28 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "b";;

let set27 : Variable_set.t = Variable_set.singleton "a" ;;

let set26 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "b";; 

let set18 : Variable_set.t = Variable_set.singleton "a" ;;

let set19 : Variable_set.t = Variable_set.singleton "a";;
  
let set20 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "b";;

let set21 : Variable_set.t = Variable_set.singleton "a";;

let set22 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "b";;

let set23 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "A";;

let set24 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "A";;

let set25 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "A";;


let set17 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "b";;

let set16 : Variable_set.t = Variable_set.singleton "a";;

let set14 : Variable_set.t = Variable_set.singleton "x"
                             |> Variable_set.add "y";;

let set15 : Variable_set.t = Variable_set.singleton "x";;

let set1 : Variable_set.t = Variable_set.singleton "a"
                            |> Variable_set.add "b" ;;

let set2 : Variable_set.t = Variable_set.singleton "a";;

let set3 : Variable_set.t = Variable_set.singleton "a1"
                            |> Variable_set.add "a2"
                            |> Variable_set.add "a3";;

let set4 : Variable_set.t = Variable_set.singleton "a";;

let set5 : Variable_set.t = Variable_set.singleton "a"
                            |> Variable_set.add "b"
                            |> Variable_set.add "c"
                            |> Variable_set.add "d";; 

let set6 : Variable_set.t = Variable_set.singleton "a"
                            |> Variable_set.add "b"
                            |> Variable_set.add "c"
                            |> Variable_set.add "d"
                            |> Variable_set.add "e"
                            |> Variable_set.add "f"
                            |> Variable_set.add "g";; 

let set7 : Variable_set.t = Variable_set.singleton "a"
                            |> Variable_set.add "b";;

let set8 : Variable_set.t = Variable_set.singleton "a"
                            |> Variable_set.add "b";;

let set9 : Variable_set.t = Variable_set.singleton "a";;

let set10 : Variable_set.t = Variable_set.singleton "a";; 

let set11 : Variable_set.t = Variable_set.singleton "a"
                             |> Variable_set.add "c"
                             |> Variable_set.add "b"
                             |> Variable_set.add "d"
                             |> Variable_set.add "z"
                             |> Variable_set.add "p"
                             |> Variable_set.add "y"
                             |> Variable_set.add "h"
                             |> Variable_set.add "x"
                             |> Variable_set.add "u"
                             |> Variable_set.add "w"
                             |> Variable_set.add "g"
                             |> Variable_set.add "v";;

let set12 : Variable_set.t = Variable_set.singleton "a";;
let set13 : Variable_set.t = Variable_set.singleton "a";;

let collect_variables_tests : (formula*Variable_set.t) list = [
  ((formula1),(set1));
  ((formula2),(set2));
  ((formula3),(set3));
  ((formula4),(set4));
  ((formula5),(set5)); 
  ((formula6),(set6)); 
  ((formula7),(set7)); 
  ((formula8),(set8)); 
  ((formula9),(set9)); 
  ((formula10),(set10)); 
  ((formula11),(set11)); 
  ((formula12),(set12)); 
  ((formula13),(set13)); 
  ((formula14),(set14)); 
  ((formula15),(set15)); 
  ((formula16),(set16)); 
  ((formula17),(set17)); 
  ((formula18),(set18)); 
  ((formula19),(set19)); 
  ((formula20),(set20)); 
  ((formula21),(set21)); 
  ((formula22),(set22)); 
  ((formula23),(set23)); 
  ((formula24),(set24)); 
  ((formula25),(set25)); 
  ((formula26),(set26)); 
  ((formula27),(set27)); 
  ((formula28),(set28)); 

]
;;

let collect_variables (formula:formula) : Variable_set.t = 
  
  let xyz = Variable_set.empty in
  
  let rec helper xyz formula : Variable_set.t = 
    match formula with
    | Variable x -> Variable_set.add x xyz
    | Conjunction (exp1,exp2) -> Variable_set.union (helper xyz exp1) (helper xyz exp2)
    | Disjunction (exp1,exp2) -> Variable_set.union (helper xyz exp1) (helper xyz exp2)
    | Negation x -> helper xyz x
  in helper xyz formula 
;;

(*Question 2*) 
let asg1 : truth_assignment =  Variable_map.singleton "x" true |> Variable_map.add    "y" false |> Variable_map.add    "z" false ;; 
let asg2 : truth_assignment =  Variable_map.singleton "x" true |> Variable_map.add    "y" false |> Variable_map.add    "z" false ;; 
let asg3 : truth_assignment =  Variable_map.singleton "x" true |> Variable_map.add    "y" false |> Variable_map.add    "z" false ;;

let form1 = parse_formula "x";;
let form2 = parse_formula "y";;
let form3 = parse_formula "z";; 
let form4 = parse_formula "x&y";;
cassertionbug corrected .. eval rdocs global. -->>