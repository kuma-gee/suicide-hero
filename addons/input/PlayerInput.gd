class_name PlayerInput extends InputReader

enum Type {
	SAME_DEVICE,
	JOYPAD,
	KEYBOARD,
}

export(Type) var type = Type.SAME_DEVICE
export var device_id = 0


func _unhandled_input(event):
	handle_input(event)


func is_player_event(event: InputEvent) -> bool:
	var joypad = type == Type.JOYPAD
	var same_device = type == Type.SAME_DEVICE
	
	return device_id == event.device and \
		(same_device or joypad == is_joypad_event(event))


static func is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion


func handle_input(event: InputEvent) -> void:
	if not is_player_event(event):
		return
	
	.handle_input(event)
