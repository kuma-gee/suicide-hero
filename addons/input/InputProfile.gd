class_name InputProfile

export var inputs = []
export var joypad = false

var mappings = {}

#func apply_profile() -> void:
#	for action in mappings.keys():
#		change_input(action)


func get_current_input(action: String) -> InputEvent:
	var inputs = InputMap.get_action_list(action)
	for i in inputs:
		if joypad and PlayerInput.is_joypad_event(i):
			return i
		if not joypad and not PlayerInput.is_joypad_event(i):
			return i
	return null


func change_input(action: String, ev: InputEvent) -> void:
	InputMap.action_erase_event(action, get_current_input(action))
	InputMap.action_add_event(action, ev)
	
#	for action in InputMap.get_action_list(action):
#		pass
