class_name InputKey extends Node

signal input_text(text)
signal input_texture(tex)

var key: int setget _set_key

const start_type_key = InputType.Key.MOUSE_LEFT

func _set_key(k: int) -> void:
	key = k
	_update()

func _update() -> void:
	if key >= start_type_key:
		emit_signal("input_texture", "res://assets/button_triangle1.png")
	else:
		emit_signal("input_text", InputType.to_text(key))
