extends Button

# Set this string to the name of the action in the InputMap
export(String) var action setget _set_action

var _editing = false

func _ready():
	InputManager.connect("device_changed", self, "_update_current_input")

func _set_action(a) -> void:
	action = a
	_update_current_input()

func _update_current_input() -> void:
	_update_button_text(InputManager.get_event(action))

func _unhandled_input(event: InputEvent) -> void:
	if _editing and not event is InputEventMouseMotion:
		InputMap.action_erase_event(action, InputManager.get_event(action))
		InputMap.action_add_event(action, event)
		
		_update_button_text(event)
		_editing = false
		pressed = false
		get_tree().set_input_as_handled()


func _update_button_text(input_event: InputEvent) -> void:
	text = InputManager.as_text(input_event)


func _on_Button_pressed() -> void:
	_editing = true
