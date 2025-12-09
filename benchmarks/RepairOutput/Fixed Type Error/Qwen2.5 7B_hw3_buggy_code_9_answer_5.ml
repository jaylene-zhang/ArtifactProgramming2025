let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  let added = fun n s -> s (n1 n s) (n2 n s) in added