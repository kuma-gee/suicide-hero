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
			if not _is_joypad(event) or event.get_action_strength(input) > 0:
				return true
	return false

func _is_joypad(event: InputEvent) -> bool:
	return event is InputEventJoypadMotion or event is InputEventJoypadButton

func _set_joypad(value: bool) -> void:
	if joypad == value: return
	
	joypad = value
	emit_signal("device_changed")

func get_event(action: String) -> InputEvent:
	for ev in InputMap.get_action_list(action):
		if joypad == _is_joypad(ev):
			return ev
	return null

func as_text(event: InputEvent) -> String:
	var text: String
	
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				text = tr("MOUSE_LEFT")
			elif event.button_index == BUTTON_RIGHT:
				text = tr("MOUSE_RIGHT")
			elif event.button_index == BUTTON_MIDDLE:
				text = tr("MOUSE_MIDDLE")
	else:
		text = event.as_text()
	return text
