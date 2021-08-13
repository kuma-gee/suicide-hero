extends InputReader

"""
Input Reader for a single player
"""

class_name PlayerInput

export var joypad = false
export var device_id = 0


func _init(device = 0, joypad = false):
	self.device_id = device
	self.joypad = joypad


func _unhandled_input(event):
	handle_input(event)


func set_for_event(event: InputEvent) -> void:
	device_id = event.device
	joypad = is_joypad_event(event)


func is_player_event(event: InputEvent) -> bool:
	return joypad == is_joypad_event(event) and device_id == event.device


static func is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion


func get_unique_name() -> String:
	return str(get_network_master()) + ":" + str(device_id) + ":" + str(joypad)


func handle_input(event: InputEvent) -> void:
	if not is_player_event(event):
		return
	
	.handle_input(event)
