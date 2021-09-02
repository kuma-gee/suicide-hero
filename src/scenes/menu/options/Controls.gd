extends MenuBase

onready var controls := $CenterContainer/VBoxContainer/MainContainer/RemappingInputs

func _on_Defaults_pressed():
	InputMap.load_from_globals()
	controls.update()

func _exit_tree():
	Settings.save_input_settings()
