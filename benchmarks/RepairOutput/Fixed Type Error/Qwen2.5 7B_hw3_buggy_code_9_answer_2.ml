let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  fun n s -> n (n1 n s) (n2 n s)