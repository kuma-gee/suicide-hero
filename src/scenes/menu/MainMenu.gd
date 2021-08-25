extends Control

onready var title := $MarginContainer/VBoxContainer/MarginContainer/CenterContainer/Title
onready var exit := $MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/Exit

func _ready():
	title.text = ProjectSettings.get_setting("application/config/name")
	if OS.get_name() == "HTML5":
		exit.hide()
		
func _on_Start_pressed():
	var _x = get_tree().change_scene("res://src/scenes/main/Main.tscn")
	GUI.open_menu(GUI.Intro, true)


func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	GUI.open_menu(GUI.Options)
