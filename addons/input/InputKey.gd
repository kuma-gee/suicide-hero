class_name InputKey extends Node

signal input_text(text)
signal input_texture(tex)

export var asset_folder = "res://assets/inputs"

var key: int setget _set_key

const start_type_key = InputType.Key.MOUSE_LEFT

func _set_key(k: int) -> void:
	key = k
	_update()

func _update() -> void:
	if key >= start_type_key:
		var path = _create_path(key)
		
		print(path + " for " + str(key))
		if not File.new().file_exists(path):
			print("Path does not exist. Using question mark")
			path = _create_path(1)
		
		emit_signal("input_texture", path)
	else:
		emit_signal("input_text", InputType.to_text(key))

func _create_path(key: int) -> String:
	return "%s/button_%s.png" % [asset_folder, key]
