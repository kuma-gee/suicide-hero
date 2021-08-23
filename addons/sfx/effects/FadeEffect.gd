class_name FadeEffect extends Effect

enum Type {
	FADE_IN,
	FADE_OUT,
}

export(Type) var type: int

func _ready():
	if start:
		node.modulate = _get_initial_value()

func _get_initial_value() -> Color:
	var alpha = 1 if type == Type.FADE_OUT else 0
	return Color(1, 1, 1, alpha)

func apply_tween(tween: Tween) -> void:
	var _start = _get_initial_value()

	var end_alpha = 0 if _start.a == 1 else 1
	var _end = Color(1, 1, 1, end_alpha)
	.interpolate_property(tween, "modulate", _start, _end)
