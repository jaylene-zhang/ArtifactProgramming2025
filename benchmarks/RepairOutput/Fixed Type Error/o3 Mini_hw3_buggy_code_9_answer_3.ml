let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun base s -> n1 (n2 base s) s