extends Button

export var menu_scene: PackedScene

export var connect_button := true

func _ready():
	if connect_button:
		var _x = connect("pressed", self, "_on_BackMenu_pressed")

func _on_BackMenu_pressed():
	back_menu()
	
func back_menu():
	var _x = get_tree().change_scene_to(menu_scene)
