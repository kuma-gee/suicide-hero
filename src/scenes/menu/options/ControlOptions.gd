extends GUIMenu

onready var controls := $CenterContainer/VBoxContainer2/RemappingInputs

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
