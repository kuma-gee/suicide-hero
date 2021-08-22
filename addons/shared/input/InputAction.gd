extends Node

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
