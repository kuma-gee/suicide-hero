extends PausedMenu

onready var score := $CenterContainer/VBoxContainer/Score

func init(data) -> void:
	score.text = tr("FINAL_LEVEL") + ": " + str(data["score"])


func _on_Menu_pressed():
	var _x = get_tree().change_scene("res://scenes/menu/Menu.tscn")
