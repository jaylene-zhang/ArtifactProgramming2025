let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun base f -> n1 (n2 base f) f