let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z f -> n1 (n2 z f) f