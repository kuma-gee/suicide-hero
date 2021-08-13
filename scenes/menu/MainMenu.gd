extends Control

onready var title := $MarginContainer/VBoxContainer/MarginContainer/CenterContainer/Title

func _ready():
	title.text = ProjectSettings.get_setting("application/config/name")


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	GUI.open_menu(GUI.InGame, true)


func _on_Exit_pressed():
	get_tree().quit()
