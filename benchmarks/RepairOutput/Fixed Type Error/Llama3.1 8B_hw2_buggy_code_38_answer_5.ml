`| Pow (l,r) -> Times (Times (Const r, Pow (l,float_of_int(r-1))), (diff l))`

should be

`| Pow (l,r) -> Times (Times (Const (float_of_int r), Pow (l,(float_of_int(r-1)))), (diff l))`

`| Pow (l,r) -> Times (Times (Const r, Pow (l,(float_of_int(r-1)))), (diff l))`