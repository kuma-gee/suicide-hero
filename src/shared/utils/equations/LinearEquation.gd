class_name LinearEquation

var rise = 0
var offset = 0


func _init(r, o):
	rise = r
	offset = o

func y(x: int) -> int:
	return rise * x + offset
