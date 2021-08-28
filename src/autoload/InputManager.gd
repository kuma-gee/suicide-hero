extends Node

signal device_changed()

export var main_device := 0
export var joypad := false setget _set_joypad

const _ui_inputs = ["ui_down", "ui_up", "ui_left", "ui_right"]

func _unhandled_input(event):
	if _is_ui_input(event):
		self.joypad = _is_joypad(event)

func _is_ui_input(event: InputEvent) -> bool:
	for input in _ui_inputs:
		if event.is_action(input):
			if not _is_joypad(event) or event is InputEventJoypadButton or event.get_action_strength(input) > 0:
				return true
	return false

func _is_joypad(event: InputEvent) -> bool:
	return event is InputEventJoypadMotion or event is InputEventJoypadButton

func _set_joypad(value: bool) -> void:
	if joypad == value: return
	
	joypad = value
	emit_signal("device_changed")
	
func get_profile() -> InputProfile:
	for profile in get_children():
		if profile.device == main_device and profile.joypad == joypad:
			return profile
		
	print("Returned null profile")
	return null
