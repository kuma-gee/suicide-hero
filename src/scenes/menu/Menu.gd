extends Control


func _ready():
	GUI.open_menu(GUI.Main, true)


func _unhandled_input(_event):
	if Input.is_action_pressed("ui_cancel") and Input.is_action_just_pressed("ui_accept"):
		GUI.open_menu(GUI.About)
		get_tree().set_input_as_handled()
