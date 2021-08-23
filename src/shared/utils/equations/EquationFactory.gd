class_name EquationFactory

static func linear(point: Vector2, dir: Vector2) -> LinearEquation:
	var rise = dir.y
	var offset = point.y - (rise * point.x)
	return LinearEquation.new(rise, offset)
