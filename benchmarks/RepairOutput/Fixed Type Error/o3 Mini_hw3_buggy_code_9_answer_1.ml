let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun a f -> n1 (n2 a f) f