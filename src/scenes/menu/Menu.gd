extends Control


func _ready():
	GUI.open_menu(GUI.Main, true)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("about"):
		GUI.open_menu(GUI.About)
