extends Button

@export var menu_scene: PackedScene

func back_menu():
	SceneManager.change_scene(menu_scene)

func _on_pressed():
	back_menu()
