class_name InputProfile extends Node

signal input_changed(action)

export var device := 0
export var joypad := false

var mappings := {}

func load_inputs(actions: Array) -> void:
	for action in actions:
		var input = get_input(action)
		if input:
			mappings[action] = InputType.to_type(input)

func apply_profile() -> void:
	for action in mappings.keys():
		var type = mappings[action]
		var ev = InputType.to_event(type)
		if ev:
			change_input(action, ev)
		else:
			print("Failed to load action %s" % action)

func is_valid(ev: InputEvent, filter_empty = false) -> bool:
	return (joypad == _is_joypad_event(ev) and device == ev.device) and \
		(not filter_empty or not _is_empty_input(ev))

func _is_empty_input(ev: InputEvent) -> bool:
	return ev is InputEventJoypadMotion and abs(ev.axis_value) <= 0.5

func get_input(action: String) -> InputEvent:
	var inputs = InputMap.get_action_list(action)
	for i in inputs:
		if is_valid(i):
			return i
	return null

func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion

func change_input(action: String, ev: InputEvent) -> void:
	InputMap.action_erase_event(action, get_input(action))
	InputMap.action_add_event(action, ev)
	emit_signal("input_changed", action)
	
