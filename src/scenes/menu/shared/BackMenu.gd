extends Button

export var menu_scene: PackedScene

func _on_BackMenu_pressed():
	var _x = get_tree().change_scene_to(menu_scene)
