let distance (x1, y1) (x2, y2) =
  let dx = float (x2 - x1) in
  let dy = float (y2 - y1) in
  sqrt (dx *. dx +. dy *. dy)