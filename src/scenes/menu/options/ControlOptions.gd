extends GUIMenu

onready var controls := $CenterContainer/OptionMenu/Container/RemappingInputs

#var actions = ["move_left", "move_up", "move"]
#
#func _ready():
#	actions = _get_mappable_actions()
#	_update_profile()
#
#func _update_profile() -> void:
#	var profile = InputManager.get_profile()
#	if profile:
#		profile.load_inputs(actions)
#	else:
#		print("No profile found")
#
#func _get_mappable_actions() -> Array:
#	var result = []
#	for child in controls.get_children():
#		result.append(child.text.to_lower())
#	return result


func _on_Defaults_pressed():
	InputMap.load_from_globals()
	controls.update()
