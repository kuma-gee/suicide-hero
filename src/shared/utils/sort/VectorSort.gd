class_name VectorSort

var point: Vector2

func _init(p):
	point = p

func sort_closest(v1: Vector2, v2: Vector2) -> bool:
	var dist1 = v1.distance_to(point)
	var dist2 = v2.distance_to(point)
	
	return dist1 < dist2
