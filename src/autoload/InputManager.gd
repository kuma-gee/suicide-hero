extends Node

signal device_changed()

export var main_device := 0
export var joypad := false setget _set_joypad

func _input(event):
	self.joypad = _is_joypad(event)

func _is_joypad(event: InputEvent) -> bool:
	return event is InputEventJoypadMotion or event is InputEventJoypadButton

func _set_joypad(value: bool) -> void:
	if joypad == value: return
	
	joypad = value
	emit_signal("device_changed")


func get_event(action: String) -> InputEvent:
	return InputMap.get_action_list(action)[0]

func as_text(input_event: InputEvent) -> String:
	var text: String
	
	if input_event is InputEventMouseButton:
			if input_event.button_index == BUTTON_LEFT:
				text = tr("MOUSE_LEFT")
			elif input_event.button_index == BUTTON_RIGHT:
				text = tr("MOUSE_RIGHT")
			elif input_event.button_index == BUTTON_MIDDLE:
				text = tr("MOUSE_MIDDLE")
	else:
		text = input_event.as_text()
	return text
