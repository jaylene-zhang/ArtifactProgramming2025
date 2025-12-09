let distance (x1, y1) (x2, y2) =
  let dx = float_of_int (x2 - x1) in
  let dy = float_of_int (y2 - y1) in
  sqrt (dx *. dx +. dy *. dy)