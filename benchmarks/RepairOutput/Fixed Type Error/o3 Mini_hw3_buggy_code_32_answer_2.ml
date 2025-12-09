let mult (n1 : 'b church) (n2 : 'b church) : 'b church =
  n1 (add n2) zero