class_name PlayerInput extends InputReader

enum Type {
	JOYPAD,
	KEYBOARD,
}

export(Type) var type = Type.KEYBOARD
export var device_id = 0

func _ready():
	_update_type()
	InputManager.connect("device_changed", self, "_update_type")


func _update_type():
	type = Type.JOYPAD if InputManager.joypad else Type.KEYBOARD
 

func _unhandled_input(event):
	handle_input(event)


func is_player_event(event: InputEvent) -> bool:
	var joypad = type == Type.JOYPAD
	return device_id == event.device and joypad == InputType.is_joypad(event)


func handle_input(event: InputEvent) -> void:
	if not is_player_event(event):
		return
	
	.handle_input(event)
