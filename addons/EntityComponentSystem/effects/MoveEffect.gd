class_name MoveEffect extends Effect

export var direction := Vector2.UP
export var offset := 10

func apply_tween(tween: Tween):
	var start = node.global_position
	var end = start + (direction * offset)
	.interpolate_property(tween, "global_position", start, end)
