let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z -> n1 z (fun x -> n2 x z)