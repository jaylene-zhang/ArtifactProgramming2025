let string_implode (l : char list) : string =
  List.fold_left (funAcc acc x -> acc ^ x) "" l