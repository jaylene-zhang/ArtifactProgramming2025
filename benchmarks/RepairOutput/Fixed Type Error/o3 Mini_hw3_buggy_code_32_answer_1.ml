let mult (n1 : 'a church) (n2 : 'a church) : 'a church =
  fun z s -> n1 z (fun x -> n2 x s)