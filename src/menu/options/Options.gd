extends MenuBase


func _on_Audio_pressed():
	GUI.open_menu(GUI.AudioOptions)


func _on_General_pressed():
	GUI.open_menu(GUI.GeneralOptions)


func _on_Controls_pressed():
	GUI.open_menu(GUI.ControlOptions)
