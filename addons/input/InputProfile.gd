class_name InputProfile

export var device := 0
export var joypad := false

var _mappings := {}

func load_inputs(actions: Array) -> void:
	for action in actions:
		var input = get_current_input(action)
		if input:
			_mappings[action] = InputType.to_type(input)

func apply_profile() -> void:
	for action in _mappings.keys():
		var type = _mappings[action]
		var ev = InputType.to_event(type)
		if ev:
			change_input(action, ev)
		else:
			print("Failed to load action %s" % action)


func get_current_input(action: String) -> InputEvent:
	var inputs = InputMap.get_action_list(action)
	for i in inputs:
		if joypad == _is_joypad_event(i) and i.device == device:
			return i
	return null

func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion

func change_input(action: String, ev: InputEvent) -> void:
	InputMap.action_erase_event(action, get_current_input(action))
	InputMap.action_add_event(action, ev)
	
#	for action in InputMap.get_action_list(action):
#		pass
