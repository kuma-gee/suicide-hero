class_name FadeEffect extends Effect

enum Type {
	FADE_IN,
	FADE_OUT,
}

export(Type) var type: int

func apply_tween(tween: Tween) -> void:
	var _start = 1 if type == Type.FADE_OUT else 0
	var _end = 0 if _start == 1 else 1
	.interpolate_property(tween, "modulate", Color(1, 1, 1, _start), Color(1, 1, 1, _end))
