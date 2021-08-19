class_name ExponentialEquation

var rise := 1.0
var offset := 0.0
var base := 2.0
var div := 1.0

var debug = false

func _init(b, r, o = 0, d = 1):
	base = b
	rise = r
	offset = o
	div = d

func y(x: int) -> float:
	if debug:
		print(str(rise) + " * " + str(base) + "^" + str(x) + "/" + str(div) + " + " + str(offset))
	return (rise * pow(base, x/div)) + offset
