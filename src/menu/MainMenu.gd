extends MenuBase

@onready var title := $CenterContainer/VBoxContainer/MainContainer/MarginContainer/CenterContainer/Title
@onready var exit := $CenterContainer/VBoxContainer/MainContainer/CenterContainer/VBoxContainer/Exit

func _ready():
	title.text = ProjectSettings.get_setting("application/config/name")
	if Env.is_web():
		exit.hide()
		
func _on_Start_pressed():
	SceneManager.change_scene("res://src/scenes/main/Main.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	GUI.open_menu(GUI.Options)
