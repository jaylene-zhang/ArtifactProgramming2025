let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  let added: 'b -> ('b -> 'b) -> 'b = fun n2 s -> s (n1) in added