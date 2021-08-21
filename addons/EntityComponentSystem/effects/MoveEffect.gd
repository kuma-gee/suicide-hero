class_name MoveEffect extends Effect

enum Type {
	GLOBAL,
	LOCAL,
}

export(Type) var type := Type.LOCAL
export var direction := Vector2.UP
export var offset := 10

func apply_tween(tween: Tween):
	var prop = "position" if type == Type.LOCAL else "global_position"
	var start = node.get(prop)
	var end = start + (direction * offset)
	.interpolate_property(tween, prop, start, end)
