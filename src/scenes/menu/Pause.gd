extends PausedMenu

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_tree().set_input_as_handled()
		_on_Resume_pressed()


func _on_Resume_pressed():
	GUI.back_menu()
