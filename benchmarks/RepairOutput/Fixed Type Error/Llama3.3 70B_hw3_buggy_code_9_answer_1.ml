let add (n1 : 'b church) (n2 : 'b church) : 'b church = 
  let added: 'b church = fun s z -> n1 s (n2 s z) in added