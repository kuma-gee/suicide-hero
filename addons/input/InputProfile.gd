class_name InputProfile extends Node

signal input_changed(action)

export var profile_name := "default"
export var device := 0
export var joypad := false

var mappings := {}

func load_mappings(_mappings: Dictionary) -> void:
	mappings = _mappings
	for action in mappings.keys():
		var type = mappings[action]
		var ev = InputType.to_event(type)
		if ev:
			change_input(action, ev)
		else:
			print("Failed to load action %s" % action)

func get_profile_name() -> String:
	return str(device) + ":" + str(joypad)

func is_valid(ev: InputEvent, filter_empty = false) -> bool:
	return (joypad == _is_joypad_event(ev) and device == ev.device) and \
		(not filter_empty or not InputType.is_empty(ev))

func get_input(action: String) -> InputEvent:
	var inputs = InputMap.get_action_list(action)
	for i in inputs:
		if is_valid(i):
			return i
	return null

func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion

func change_input(action: String, ev: InputEvent) -> void:
	var existing = get_input(action)
	if existing:
		InputMap.action_erase_event(action, existing)
	InputMap.action_add_event(action, ev)
	
	mappings[action] = InputType.to_type(ev)
	emit_signal("input_changed", action)
	
