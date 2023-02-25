extends PausedMenu

func _input(event):
	if event is InputEventMouseButton:
		var e = event as InputEventMouseButton
		if e.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled()
			close()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		close()

func close() -> void:
	GUI.open_menu(GUI.InGame, true)
