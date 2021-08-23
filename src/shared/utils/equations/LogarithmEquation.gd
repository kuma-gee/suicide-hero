class_name LogarithmEquation

var rise := 1
var offset := 0

func _init(r, o):
	rise = r
	offset = o

func y(x: int) -> float:
	return (rise * log(x)) + offset
