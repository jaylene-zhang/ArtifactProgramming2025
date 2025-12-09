let add (n1 : 'b church) (n2 : 'b church) : 'b church =
  fun z -> n2 (n1 z) (fun s -> n2 s (fun z -> z))