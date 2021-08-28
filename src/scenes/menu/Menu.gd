extends Control

onready var input := $PlayerInput

func _ready():
	GUI.open_menu(GUI.Main, true)

func _unhandled_input(_event):
	if input.is_pressed("ui_cancel") and input.is_pressed("ui_accept"):
		GUI.open_menu(GUI.About)
		get_tree().set_input_as_handled()
