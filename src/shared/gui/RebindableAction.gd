extends Button

# Set this string to the name of the action in the InputMap
export(String) var action setget _set_action

var _editing = false

func _set_action(a) -> void:
	action = a
	_update_button_text(InputManager.get_event(action))

func _input(input_event: InputEvent) -> void:
	if _editing and not input_event is InputEventMouseMotion:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, input_event)
		
		_update_button_text(input_event)
		_editing = false
		pressed = false
		get_tree().set_input_as_handled()


func _update_button_text(input_event: InputEvent) -> void:
	text = InputManager.as_text(input_event)


func _on_Button_pressed() -> void:
	_editing = true
