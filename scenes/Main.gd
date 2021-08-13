extends Node


func _ready():
	Game.connect("game_start", self, "start")
	Game.connect("game_ended", self, "end")


func start():
	GUI.open_menu(GUI.InGame, true)

func end():
	for child in get_children():
		remove_child(child)
	
	GUI.open_menu(GUI.MainMenu, true)
