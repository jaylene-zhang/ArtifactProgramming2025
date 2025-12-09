let mult (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun z s -> add (n2 (n1 z s) s) zero